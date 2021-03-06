----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2018 21:11:33
-- Design Name: 
-- Module Name: filtrosobel5x5g1 - Behavioral
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

entity filtrosobel5x5g2 is
Port (clk: in std_logic;--clock
      reset: in std_logic;--reset
      pxin: in std_logic_vector(7 downto 0);--pixel de entrada
      pxout: out std_logic_vector(11 downto 0);--pixel de sa�da
      ready: out std_logic);--ready
end filtrosobel5x5g2;

architecture Behavioral of filtrosobel5x5g2 is
--criando kernel Gx
--primeira linha
constant Gx11: std_logic_vector(2 downto 0):="001"; -- 1
constant Gx12: std_logic_vector(2 downto 0):="010";-- 2
constant Gx13: std_logic_vector(2 downto 0):="001";-- 1
constant Gx14: std_logic_vector(2 downto 0):="010";-- 2
constant Gx15: std_logic_vector(2 downto 0):="001"; -- 1
--segunda linha
constant Gx21: std_logic_vector(2 downto 0):="001"; -- 1
constant Gx22: std_logic_vector(2 downto 0):="010";-- 2
constant Gx23: std_logic_vector(2 downto 0):="001";-- 1
constant Gx24: std_logic_vector(2 downto 0):="010";-- 2
constant Gx25: std_logic_vector(2 downto 0):="001"; -- 1
--terceira linha
constant Gx31: std_logic_vector(2 downto 0):="000"; -- 0
constant Gx32: std_logic_vector(2 downto 0):="000";-- 0
constant Gx33: std_logic_vector(2 downto 0):="000";-- 0
constant Gx34: std_logic_vector(2 downto 0):="000";-- 0
constant Gx35: std_logic_vector(2 downto 0):="000"; -- 0
--quarta linha
constant Gx41: std_logic_vector(2 downto 0):="111"; -- -1
constant Gx42: std_logic_vector(2 downto 0):="110";-- -1
constant Gx43: std_logic_vector(2 downto 0):="111";-- -1
constant Gx44: std_logic_vector(2 downto 0):="110";-- -1
constant Gx45: std_logic_vector(2 downto 0):="111"; -- -1
--quinta linha
constant Gx51: std_logic_vector(2 downto 0):="111"; -- -2
constant Gx52: std_logic_vector(2 downto 0):="110";-- -1
constant Gx53: std_logic_vector(2 downto 0):="111";-- 0
constant Gx54: std_logic_vector(2 downto 0):="110";-- 1
constant Gx55: std_logic_vector(2 downto 0):="110"; -- 2

--cria��o dos sinais de entrada
--primeira linha
signal A11: std_logic_vector(8 downto 0):=(others=>'0');
signal A12: std_logic_vector(8 downto 0):=(others=>'0');
signal A13: std_logic_vector(8 downto 0):=(others=>'0');
signal A14: std_logic_vector(8 downto 0):=(others=>'0');
signal A15: std_logic_vector(8 downto 0):=(others=>'0');
--segunda linha
signal A21: std_logic_vector(8 downto 0):=(others=>'0');
signal A22: std_logic_vector(8 downto 0):=(others=>'0');
signal A23: std_logic_vector(8 downto 0):=(others=>'0');
signal A24: std_logic_vector(8 downto 0):=(others=>'0');
signal A25: std_logic_vector(8 downto 0):=(others=>'0');
--terceira linha
signal A31: std_logic_vector(8 downto 0):=(others=>'0');
signal A32: std_logic_vector(8 downto 0):=(others=>'0');
signal A33: std_logic_vector(8 downto 0):=(others=>'0');
signal A34: std_logic_vector(8 downto 0):=(others=>'0');
signal A35: std_logic_vector(8 downto 0):=(others=>'0');
--quarta linha
signal A41: std_logic_vector(8 downto 0):=(others=>'0');
signal A42: std_logic_vector(8 downto 0):=(others=>'0');
signal A43: std_logic_vector(8 downto 0):=(others=>'0');
signal A44: std_logic_vector(8 downto 0):=(others=>'0');
signal A45: std_logic_vector(8 downto 0):=(others=>'0');
--quinta linha
signal A51: std_logic_vector(8 downto 0):=(others=>'0');
signal A52: std_logic_vector(8 downto 0):=(others=>'0');
signal A53: std_logic_vector(8 downto 0):=(others=>'0');
signal A54: std_logic_vector(8 downto 0):=(others=>'0');
signal A55: std_logic_vector(8 downto 0):=(others=>'0');

--criando os sinais dos resultados de multiplica��o
--primeira linha
signal M11: std_logic_vector(11 downto 0):=(others=>'0');
signal M12: std_logic_vector(11 downto 0):=(others=>'0');
signal M13: std_logic_vector(11 downto 0):=(others=>'0');
signal M14: std_logic_vector(11 downto 0):=(others=>'0');
signal M15: std_logic_vector(11 downto 0):=(others=>'0');
--segunda linha
signal M21: std_logic_vector(11 downto 0):=(others=>'0');
signal M22: std_logic_vector(11 downto 0):=(others=>'0');
signal M23: std_logic_vector(11 downto 0):=(others=>'0');
signal M24: std_logic_vector(11 downto 0):=(others=>'0');
signal M25: std_logic_vector(11 downto 0):=(others=>'0');
--terceira linha
signal M31: std_logic_vector(11 downto 0):=(others=>'0');
signal M32: std_logic_vector(11 downto 0):=(others=>'0');
signal M33: std_logic_vector(11 downto 0):=(others=>'0');
signal M34: std_logic_vector(11 downto 0):=(others=>'0');
signal M35: std_logic_vector(11 downto 0):=(others=>'0');
--quarta linha
signal M41: std_logic_vector(11 downto 0):=(others=>'0');
signal M42: std_logic_vector(11 downto 0):=(others=>'0');
signal M43: std_logic_vector(11 downto 0):=(others=>'0');
signal M44: std_logic_vector(11 downto 0):=(others=>'0');
signal M45: std_logic_vector(11 downto 0):=(others=>'0');
--quinta linha
signal M51: std_logic_vector(11 downto 0):=(others=>'0');
signal M52: std_logic_vector(11 downto 0):=(others=>'0');
signal M53: std_logic_vector(11 downto 0):=(others=>'0');
signal M54: std_logic_vector(11 downto 0):=(others=>'0');
signal M55: std_logic_vector(11 downto 0):=(others=>'0');
--sinal para a FIFO
signal regwin: std_logic_vector(405*8-1 downto 0):=(others=>'0');
--sinal para a sa�da do somador
signal sumout1: std_logic_vector(11 downto 0):=(others=>'0');

begin
--processo para o ready
process(clk,reset)
variable count: integer range 0 to 405+3 :=0;--vari�vel para a FIFO
begin
if reset='1' then
ready<='0';
count :=0;
elsif rising_edge(clk) then
if count=408 then
count :=0;
ready<='1';
else
count := count+1;
end if;
end if;
end process;
--processo para gerar a FIFO
process(clk,reset)
begin
if reset='1' then
regwin<=(others=>'0');
elsif rising_edge(clk) then
regwin<= pxin & regwin(405*8-1 downto 8);
end if;
end process;

A11 <= '0'& regwin(7 downto 0);
A12 <= '0'& regwin(15 downto 8);
A13 <= '0'& regwin(23 downto 16);
A14 <= '0'& regwin(31 downto 24);
A15 <= '0'& regwin(39 downto 32);

A21 <= '0'& regwin(101*8-1 downto 101*8-8);
A22 <= '0'& regwin(102*8-1 downto 102*8-8);
A23 <= '0'& regwin(103*8-1 downto 103*8-8);
A24 <= '0'& regwin(104*8-1 downto 104*8-8);
A25 <= '0'& regwin(105*8-1 downto 105*8-8);

A31 <= '0'& regwin(201*8-1 downto 201*8-8);
A32 <= '0'& regwin(202*8-1 downto 202*8-8);
A33 <= '0'& regwin(203*8-1 downto 203*8-8);
A34 <= '0'& regwin(204*8-1 downto 204*8-8);
A35 <= '0'& regwin(205*8-1 downto 205*8-8);

A41 <= '0'& regwin(301*8-1 downto 301*8-8);
A42 <= '0'& regwin(302*8-1 downto 302*8-8);
A43 <= '0'& regwin(303*8-1 downto 303*8-8);
A44 <= '0'& regwin(304*8-1 downto 304*8-8);
A45 <= '0'& regwin(305*8-1 downto 305*8-8);

A51 <= '0'& regwin(401*8-1 downto 401*8-8);
A52 <= '0'& regwin(402*8-1 downto 402*8-8);
A53 <= '0'& regwin(403*8-1 downto 403*8-8);
A54 <= '0'& regwin(404*8-1 downto 404*8-8);
A55 <= '0'& regwin(405*8-1 downto 405*8-8);
--processos para multiplicar A*Gx
process(clk,reset)
begin
if reset='1' then
M11<=(others=>'0');
elsif rising_edge(clk) then
M11<=A11*Gx11;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M12<=(others=>'0');
elsif rising_edge(clk) then
M12<=A12*Gx12;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M13<=(others=>'0');
elsif rising_edge(clk) then
M13<=A13*Gx13;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M14<=(others=>'0');
elsif rising_edge(clk) then
M14<=A14*Gx14;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M15<=(others=>'0');
elsif rising_edge(clk) then
M15<=A15*Gx15;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M21<=(others=>'0');
elsif rising_edge(clk) then
M21<=A21*Gx21;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M22<=(others=>'0');
elsif rising_edge(clk) then
M22<=A22*Gx22;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M23<=(others=>'0');
elsif rising_edge(clk) then
M23<=A23*Gx23;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M24<=(others=>'0');
elsif rising_edge(clk) then
M24<=A24*Gx24;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M25<=(others=>'0');
elsif rising_edge(clk) then
M25<=A25*Gx25;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M31<=(others=>'0');
elsif rising_edge(clk) then
M31<=A31*Gx31;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M32<=(others=>'0');
elsif rising_edge(clk) then
M32<=A32*Gx32;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M33<=(others=>'0');
elsif rising_edge(clk) then
M33<=A33*Gx33;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M34<=(others=>'0');
elsif rising_edge(clk) then
M34<=A34*Gx34;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M35<=(others=>'0');
elsif rising_edge(clk) then
M35<=A35*Gx35;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M41<=(others=>'0');
elsif rising_edge(clk) then
M41<=A41*Gx41;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M42<=(others=>'0');
elsif rising_edge(clk) then
M42<=A42*Gx42;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M43<=(others=>'0');
elsif rising_edge(clk) then
M43<=A43*Gx43;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M44<=(others=>'0');
elsif rising_edge(clk) then
M44<=A44*Gx44;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M45<=(others=>'0');
elsif rising_edge(clk) then
M45<=A45*Gx45;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M51<=(others=>'0');
elsif rising_edge(clk) then
M51<=A51*Gx51;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M52<=(others=>'0');
elsif rising_edge(clk) then
M52<=A52*Gx52;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M53<=(others=>'0');
elsif rising_edge(clk) then
M53<=A53*Gx53;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M54<=(others=>'0');
elsif rising_edge(clk) then
M54<=A54*Gx54;
end if;
end process;

process(clk,reset)
begin
if reset='1' then
M55<=(others=>'0');
elsif rising_edge(clk) then
M55<=A55*Gx55;
end if;
end process;

--processo para acumular
process(clk,reset)
begin
if reset='1' then
sumout1<=(others=>'0');
elsif rising_edge(clk) then
sumout1<=M11+M12+M13+M14+M15+M21+M22+M23+M24+M25+M31+M32+M33+M34+M35+M41+M42+M43+M44+M45+M51+M52+M53+M54+M55;
end if;
end process;
--processo de compara��o
process(clk,reset)
begin
if reset='1' then
pxout<=(others=>'0');
elsif rising_edge(clk) then
if sumout1(11)='1' then
pxout<=(others=>'0');
elsif sumout1 > "000011111111" then
pxout<="000011111111";
else
pxout<=sumout1;
end if;
end if;
end process;
end Behavioral;
