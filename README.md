# 🚀 Hardware Implementation of Sobel Edge Detection on FPGA

> Real-time image processing using FPGA with VGA output  
> Verilog-based pipelined architecture for high-speed edge detection  

---

## 📌 Overview

This project implements a **Sobel Edge Detection system on FPGA** using Verilog HDL. The system processes a grayscale image stored in on-chip memory (BRAM) and displays the edge-detected output on a VGA monitor.

Unlike software-based approaches, this design performs **parallel hardware computation**, enabling fast and efficient image processing directly on FPGA.

---

## 🎯 Objective

- Implement Sobel edge detection in hardware  
- Process image data efficiently using FPGA  
- Achieve real-time performance  
- Display output using VGA interface  

---

## ⚡ Key Features

- Real-time edge detection  
- Pixel-by-pixel processing  
- Pipelined hardware architecture  
- VGA output display (640×480)  
- Efficient memory usage using BRAM  
- Modular and scalable design  

---

## 🧠 Important Concepts Used

### 🔹 Real-Time Processing
Real-time means the system processes and displays data **immediately as it is being read**, without noticeable delay.  
In this project, once the pipeline is filled, the FPGA processes **one pixel per clock cycle**, and the output is displayed continuously on the VGA screen.

---

### 🔹 Streaming Dataflow (Hardware Perspective)
Streaming means data flows **continuously through different modules** without storing the entire image.

In this design:
- Pixels are read sequentially from BRAM  
- Passed through line buffer → Sobel → VGA  
- Each module processes data and forwards it instantly  

This avoids full-frame storage and improves speed and efficiency.

---

## 🏗️ System Architecture

The system consists of the following major components:

- **BRAM** → Stores grayscale image  
- **Line Buffer** → Generates 3×3 pixel window  
- **Sobel Module** → Computes edges  
- **VGA Controller** → Displays output  

### Data Flow:

BRAM → Pixel Register → Line Buffer → Sobel → VGA Output

---

## ⚙️ Working

1. Image is converted to grayscale and resized to 256×256  
2. Image is stored in BRAM using a COE file  
3. VGA controller generates pixel coordinates  
4. Pixel values are read from memory  
5. Line buffer forms 3×3 window  
6. Sobel module computes edge intensity  
7. Output is displayed on VGA  

After initial delay, the system continuously processes pixels and displays results in real time.

---

## 🧩 Modules Description

| Module | Function |
|------|--------|
| Top Module | Integrates all components |
| VGA Controller | Generates sync signals and coordinates |
| Line Buffer | Creates 3×3 pixel window |
| Sobel Module | Computes edge gradients |
| BRAM | Stores input image |

---

## 🛠️ Tools & Technologies

- FPGA Board: Nexys 4 DDR (Artix-7)  
- Software: Xilinx Vivado 2023.2  
- Language: Verilog HDL  
- Python: OpenCV, NumPy  
- Display: VGA  

---

## 🖼️ Image Preprocessing

Before loading into FPGA:

- Convert image to grayscale  
- Resize to 256×256  
- Convert to COE file for BRAM  

---

## ▶️ How to Run

1. Open Vivado and create project for Nexys 4 DDR  
2. Add Verilog source files  
3. Add constraint (.xdc) file  
4. Generate BRAM IP and load COE file  
5. Run synthesis and implementation  
6. Generate bitstream  
7. Program FPGA  
8. Connect VGA monitor and observe output  

---

## 📊 Results

- Edge-detected image displayed successfully on VGA  
- Clear boundary detection  
- Smooth output without flickering  
- Correct synchronization between modules  

The system processes image data continuously and efficiently.

---

## ⚠️ Challenges Faced

- BRAM latency → solved using register stage  
- Line buffer initialization → handled using valid signals  
- VGA timing issues → synchronized using pixel clock  
- Pipeline delay → analyzed using simulation  

---

## 🚀 Future Improvements

- Pipeline delay compensation  
- RGB image support  
- Canny edge detection  
- Camera input integration (OV7670)  
- Higher resolution support  
- Hardware optimization using AXI-stream  

---

## 📄 Documentation

📘 Final Report included in repository  

---

## ⭐ Summary

This project demonstrates how FPGA can be used for **high-speed real-time image processing** using a pipelined and streaming architecture. It provides a strong foundation for building advanced hardware-based vision systems.

---

⭐ If you found this useful, consider starring the repository!
