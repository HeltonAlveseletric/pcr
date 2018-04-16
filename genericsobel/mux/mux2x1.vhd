----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2018 23:20:54
-- Design Name: 
-- Module Name: mux2x1 - Behavioral
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

entity mux2x1 is
generic (N:integer:=8);
    Port (a : in STD_LOGIC_VECTOR(N+3 downto 0);
           b : in STD_LOGIC_VECTOR (N+3 downto 0);
           sel : in STD_LOGIC;
           outk:out std_logic_vector(N+3 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is
signal out1:std_logic_vector(N+3 downto 0):=(others=>'0');
begin
process(a,b,sel)
begin
if sel='0' then
out1<=a;
elsif sel='1' then
out1<=b;
else
out1<=(others=>'0');
end if;
end process;
outk<=out1;
end Behavioral;
