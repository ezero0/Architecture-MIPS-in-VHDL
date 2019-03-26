# Architecture MIPS

Project created for subject "Arquitectura de Computadoras" trimester 18-P by Dr. Eduardo Rodriguez Martinez

## Introduction
A processor MIPS is a part of RISC Processors Architecture Family. Used by devices like PSP, Playstation 2 and Routers Cisco (among others), the processor MIPS have a much utility in Embedded System world. The Instructions Type's and more information is addressed in the PDF "ARQUITECTURAS MIPS EN VHDL" (written in spanish) of this repository.

## Development Enviroment
Visual Studio Code, GHDL, GtkWave

### Compilation and Simulation Example
```sh
$ ghdl -a data_memory.vhdl
$ ghdl -a data_memorytb.vhdl
$ ghdl -e data_memorytb
$ ghdl -r data_memorytb --stop-time=5000ns --vcd=grafico1.vcd
$ gtkwave grafico1.vcd
```
In process...

