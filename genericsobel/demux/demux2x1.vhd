----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2018 12:29:55
-- Design Name: 
-- Module Name: demux2x1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux2x1 is
generic (N: integer:=8);
Port (in1:in std_logic_vector(N-1 downto 0);
      outa: out std_logic_vector(N-1 downto 0);
      outb: out std_logic_vector(N-1 downto 0);
      sel: in std_logic );
end demux2x1;

architecture Behavioral of demux2x1 is
signal outak: std_logic_vector(N-1 downto 0):=(others=>'0');
signal outbk: std_logic_vector(N-1 downto 0):=(others=>'0');
begin
process(sel,in1)
begin
if sel='0' then
outak<=in1;
outbk<=(others=>'0');
elsif sel='1' then
outak<=(others=>'0');
outbk<=in1;
else
outak<=(others=>'0');
outbk<=(others=>'0');
end if;
end process;
outa<=outak;
outb<=outbk;
end Behavioral;
