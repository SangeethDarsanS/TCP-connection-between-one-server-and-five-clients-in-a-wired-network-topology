# NS2 TCP Client-Server Simulation

This repository contains an NS2 Tcl simulation script that demonstrates a basic **TCP communication** between **five clients** and **one server** in a wired network setup.

## 🧠 Simulation Overview

- **Simulator**: NS2
- **Traffic Type**: TCP
- **Application Layer**: FTP
- **Network Type**: Wired point-to-point
- **Queue Type**: DropTail
- **Clients**: 5
- **Server**: 1
- **Link Bandwidth**: 1 Mb
- **Link Delay**: 10 ms

## 📂 Files Included

| File Name          | Description                              |
|-------------------|------------------------------------------|
| `tcp_clients.tcl`  | Main Tcl script for NS2 simulation       |
| `tcp_clients.tr`   | NS2 trace file generated after run       |
| `tcp_clients.nam`  | NAM file for network animation           |
| `README.md`        | Project documentation                    |
| `screenshots/`     | 📸 Folder to place NAM simulation images |

## 🚀 How to Run

### ✅ Prerequisites

Make sure you have NS2 and NAM installed on your Ubuntu/Linux system.

### 🛠️ Run the simulation

```bash
ns tcp_clients.tcl
````

### 📺 View the Output

After the simulation ends, NAM will launch automatically:

* Observe packet flow between clients and server
* Use slow/fast forward buttons to control simulation

## 📈 Output Preview

### NAM Output
### Start
![Image](https://github.com/user-attachments/assets/2a929903-4ddb-49eb-88fa-29100cb52668)
### Mid
![Image](https://github.com/user-attachments/assets/0b092c9c-b876-4c75-8266-c0c8e186f39d)
### End
![Image](https://github.com/user-attachments/assets/40019eac-60d9-4541-82f3-7bbcfd07865c)

## 🧪 Future Improvements

* Add xgraph visualization (throughput/delay)
* Implement queue monitoring
* Simulate shared medium or bottleneck topology

## 📜 License

This project is open-source and free to use for academic or research purposes.

### ✅ How to Use

1. Save the above as `README.md` in your GitHub repo.
2. Create a folder called `screenshots` inside your repo.
3. Place NAM simulation screenshots there.
4. Commit everything to your GitHub repository.
5. Also check wheather the Xming file is running

