# Create Simulator
set ns [new Simulator]

# Setup trace and NAM files
set tracefile [open tcp_clients.tr w]
set namfile [open tcp_clients.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Create nodes
set server [$ns node]
for {set i 0} {$i < 5} {incr i} {
    set client($i) [$ns node]
}

# Link each client to the server via duplex links
for {set i 0} {$i < 5} {incr i} {
    $ns duplex-link $client($i) $server 1Mb 10ms DropTail
}

# Color nodes
$ns color 1 Blue    ;# Clients
$ns color 2 Red     ;# Server

# Create TCP connections from each client to server
for {set i 0} {$i < 5} {incr i} {
    # TCP Agent at client
    set tcp($i) [new Agent/TCP]
    $tcp($i) set class_ 1
    $ns attach-agent $client($i) $tcp($i)

    # Sink at server
    set sink($i) [new Agent/TCPSink]
    $ns attach-agent $server $sink($i)

    # Connect TCP to Sink
    $ns connect $tcp($i) $sink($i)

    # FTP app over TCP
    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp($i)

    # Start FTP traffic
    set startTime [expr 1.0 + ($i * 0.5)]
    $ns at $startTime "$ftp($i) start"
}

# Finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    puts "Simulation complete. Opening NAM..."
    exec nam tcp_clients.nam &
    exit 0
}

# Schedule finish
$ns at 10.0 "finish"

# Run simulation
$ns run

