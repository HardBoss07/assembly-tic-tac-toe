# Tic Tac Toe - x86 / x86_64 Assembly Engine

A low-level implementation of Tic Tac Toe written in Assembly to explore register-level logic, memory management, and system call interfaces. The project traces an architectural evolution from legacy 16-bit real-mode DOS programming in `emu8086` to modern 64-bit x86_64 Linux Assembly using native POSIX system calls.

## Technical Overview & Core Learning Objectives

- **Dual-Architecture Systems:** Evaluated architectural differences between 16-bit Real Mode (DOS BIOS interrupts) and 64-bit Long Mode (Linux `sys_write` and `sys_read` kernel interfaces).
- **Register & Branching Logic:** Engineered conditional evaluation routines utilizing low-level compare (`CMP`) instructions and jump flags (`JNZ`, `JZ`) to track game state and validate win matrices.
- **Direct Terminal Manipulation:** Interfaced with raw terminal drivers using ANSI escape sequences and Linux `termios` structures via `ioctl` system calls to handle single-character non-canonical input without waiting for newline buffered input.
- **Memory & Input Integrity:** Developed collision-handling state machines that validate square availability directly in memory, preventing unauthorized cell overrides while rendering error buffers.

## Tech Stack

- **Languages:** x86 Assembly (16-bit Real Mode), x86_64 Assembly (NASM syntax)
- **Build System:** GNU Make
- **Assembler & Linker:** NASM, GNU Linker (`ld`)
- **Target Environments:** `emu8086` Emulator (DOS), x86_64 Linux
- **Low-Level Interfaces:** DOS Interrupts (`INT 10h`, `INT 21h`), Linux System Calls (`syscall`: `sys_read`, `sys_write`, `ioctl`)

## Key Features & Architecture

- **Branch-Based Win Detection Evaluator:** Inspects all eight victory vectors (3 rows, 3 columns, 2 diagonals) in memory sequentially following each move, setting win status registers instantly upon detection.
- **Raw Terminal Input Handler:** Configures input stream properties in Linux to capture raw user keypresses instantaneously, bypassing standard OS input buffering.
- **Interactive Grid Validation Engine:** Manages a board array in data memory, cross-checking candidate moves against active cell states and executing dynamic screen-redraw or error-recovery routines.
- **Cross-Platform UI Rendering:** Uses BIOS display pages in the 16-bit version (`tic-tac-toe.asm`) and ANSI screen-clearing sequences in 64-bit Linux (`linux-x86_64-tic-tac-toe.nasm`) to render terminal-based visual layouts.

## Assembling & Running

### Linux x86_64 (NASM & Make)

1. **Clone the repository:**

```bash
git clone https://github.com/HardBoss07/assembly-tic-tac-toe.git
cd assembly-tic-tac-toe
```

2. **Build and run automatically using Make:**

```bash
make
```

3. **Manual assembly step (alternative):**

```bash
nasm -f elf64 linux-x86_64-tic-tac-toe.nasm -o linux-x86_64-tic-tac-toe.o
ld linux-x86_64-tic-tac-toe.o -o linux-x86_64-tic-tac-toe
./linux-x86_64-tic-tac-toe
```

4. **Clean build artifacts:**

```bash
make clean
```

### 16-bit DOS (`emu8086`)

1. Open `tic-tac-toe.asm` directly in the **emu8086** emulator interface.
2. Click **Compile and Emulate**.
3. Launch the generated executable within the built-in emulator window.
