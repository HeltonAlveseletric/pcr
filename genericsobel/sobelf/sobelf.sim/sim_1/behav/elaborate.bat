@echo off
set xv_path=D:\\Vivado\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 8e226c8c407a48c19f82860e52934f87 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_sobelf_behav xil_defaultlib.tb_sobelf -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
