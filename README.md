# AHB-to-APB-Bridge-Design
Design an AHB to APB Bridge RTL using verilog in Xilinx VIVADO.
The AHB to APB Bridge is a hardware design that facilitates communication between the AHB (Advanced High-performance Bus) and APB (Advanced Peripheral Bus) in a system. This bridge connects an AHB-based system to peripheral devices that communicate over the APB interface. The design supports three peripheral interfaces, allowing the system to control and interact with different devices through the APB.

This project is aimed at enabling the integration of peripherals that use the APB protocol with an AHB-based system, commonly used in ARM architectures.

Features
AHB to APB Bridge: A bridge between AHB (Master) and APB (Slave).
Support for 3 Peripheral Interfaces: The bridge handles communication with up to 3 different peripheral devices on the APB.
Efficient Data Transfer: Enables seamless data transfer between AHB and APB peripherals.
Scalable Design: The bridge design can be expanded to support more peripherals or different communication protocols if needed.
Synchronous Operation: Ensures reliable operation between AHB and APB clock.

The AHB to APB bridge consists of:

AHB Master Interface: Receives commands from the AHB master.
Bridge Logic: Converts AHB transactions to APB transactions. Handles address decoding and control signal mapping.
Peripheral Interfaces (3 APB devices): The bridge connects to three APB peripherals. Each interface communicates with a specific peripheral via the APB protocol.
APB Slave Interfaces: Each peripheral (up to 3) can be accessed by the AHB system.
The design supports read and write operations between the AHB master and the connected APB peripherals.
