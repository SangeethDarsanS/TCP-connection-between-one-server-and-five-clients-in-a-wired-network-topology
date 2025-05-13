# Create Simulator
set ns [new Simulator]

# Setup trace and NAM files
set tracefile [open aodv_udp.tr w]
set namfile [open aodv_udp.nam w]
$ns trace-all $tracefile
$ns namtrace-all-wireless $namfile 500 500

# Setup topography
set topo [new Topography]
$topo load_flatgrid 500 500

# Define wireless channel
set chan_1_ [new Channel/WirelessChannel]

# Node configuration (must come BEFORE node creation)
$ns node-config -adhocRouting AODV \
    -llType LL \
    -macType Mac/802_11 \
    -ifqType Queue/DropTail/PriQueue \
    -ifqLen 50 \
    -antType Antenna/OmniAntenna \
    -propType Propagation/TwoRayGround \
    -phyType Phy/WirelessPhy \
    -channel $chan_1_ \
    -topoInstance $topo \
    -agentTrace ON \
    -routerTrace ON \
    -macTrace OFF

# ✅ Call create-god BEFORE node creation
create-god 3

# Create 3 mobile nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Set initial node positions
$n0 set X_ 50.0;  $n0 set Y_ 100.0;  $n0 set Z_ 0.0
$n1 set X_ 150.0; $n1 set Y_ 100.0;  $n1 set Z_ 0.0
$n2 set X_ 250.0; $n2 set Y_ 100.0;  $n2 set Z_ 0.0

# Define node movements (optional)
$ns at 1.0 "$n0 setdest 200.0 100.0 10.0"
$ns at 1.0 "$n2 setdest 50.0 100.0 10.0"

# Setup UDP and Null agents
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set null0 [new Agent/Null]
$ns attach-agent $n2 $null0

# Connect UDP agent to Null agent
$ns connect $udp0 $null0

# Generate CBR traffic on top of UDP
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 512
$cbr0 set interval_ 0.2
$cbr0 attach-agent $udp0

# Start/Stop traffic
$ns at 2.0 "$cbr0 start"
$ns at 8.0 "$cbr0 stop"

# Finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    puts "Simulation completed. Opening NAM..."
    exec nam aodv_udp.nam &
    exit 0
}

# Schedule simulation end
$ns at 10.0 "finish"

# Run the simulation
$ns run

