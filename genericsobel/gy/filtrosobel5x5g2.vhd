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
generic(N: integer:=8);
Port (clk: in std_logic;--clock
      reset: in std_logic;--reset
      pxin: in std_logic_vector(N-1 downto 0);--pixel de entrada
      pxout: out std_logic_vector(N+3 downto 0);--pixel de saída
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

--criação dos sinais de entrada
--primeira linha
signal A11: std_logic_vector(N downto 0):=(others=>'0');
signal A12: std_logic_vector(N downto 0):=(others=>'0');
signal A13: std_logic_vector(N downto 0):=(others=>'0');
signal A14: std_logic_vector(N downto 0):=(others=>'0');
signal A15: std_logic_vector(N downto 0):=(others=>'0');
--segunda linha
signal A21: std_logic_vector(N downto 0):=(others=>'0');
signal A22: std_logic_vector(N downto 0):=(others=>'0');
signal A23: std_logic_vector(N downto 0):=(others=>'0');
signal A24: std_logic_vector(N downto 0):=(others=>'0');
signal A25: std_logic_vector(N downto 0):=(others=>'0');
--terceira linha
signal A31: std_logic_vector(N downto 0):=(others=>'0');
signal A32: std_logic_vector(N downto 0):=(others=>'0');
signal A33: std_logic_vector(N downto 0):=(others=>'0');
signal A34: std_logic_vector(N downto 0):=(others=>'0');
signal A35: std_logic_vector(N downto 0):=(others=>'0');
--quarta linha
signal A41: std_logic_vector(N downto 0):=(others=>'0');
signal A42: std_logic_vector(N downto 0):=(others=>'0');
signal A43: std_logic_vector(N downto 0):=(others=>'0');
signal A44: std_logic_vector(N downto 0):=(others=>'0');
signal A45: std_logic_vector(N downto 0):=(others=>'0');
--quinta linha
signal A51: std_logic_vector(N downto 0):=(others=>'0');
signal A52: std_logic_vector(N downto 0):=(others=>'0');
signal A53: std_logic_vector(N downto 0):=(others=>'0');
signal A54: std_logic_vector(N downto 0):=(others=>'0');
signal A55: std_logic_vector(N downto 0):=(others=>'0');

--criando os sinais dos resultados de multiplicação
--primeira linha
signal M11: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M12: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M13: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M14: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M15: std_logic_vector(N+3 downto 0):=(others=>'0');
--segunda linha
signal M21: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M22: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M23: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M24: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M25: std_logic_vector(N+3 downto 0):=(others=>'0');
--terceira linha
signal M31: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M32: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M33: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M34: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M35: std_logic_vector(N+3 downto 0):=(others=>'0');
--quarta linha
signal M41: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M42: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M43: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M44: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M45: std_logic_vector(N+3 downto 0):=(others=>'0');
--quinta linha
signal M51: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M52: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M53: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M54: std_logic_vector(N+3 downto 0):=(others=>'0');
signal M55: std_logic_vector(N+3 downto 0):=(others=>'0');

--- definindo limitador para N=8 ou N=10
constant k1:std_logic_vector(11 downto 0):="000011111111";--255 para N=8
constant k2:std_logic_vector(13 downto 0):="00000011111111";--255 para N=10
--sinal para a FIFO
signal regwin: std_logic_vector(405*N-1 downto 0):=(others=>'0');
--sinal para a saída do somador
signal sumout: std_logic_vector(N+3 downto 0):=(others=>'0');

begin
--processo para o ready
process(clk,reset)
variable count: integer range 0 to 405+3 :=0;--variável para a FIFO
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
regwin<= pxin & regwin(405*N-1 downto N);
end if;
end process;

A11 <= '0'& regwin(N-1 downto 0);
A12 <= '0'& regwin(2*N-1 downto N);
A13 <= '0'& regwin(3*N-1 downto 2*N);
A14 <= '0'& regwin(4*N-1 downto 3*N);
A15 <= '0'& regwin(5*N-1 downto 4*N);

A21 <= '0'& regwin(101*N-1 downto 101*N-N);
A22 <= '0'& regwin(102*N-1 downto 102*N-N);
A23 <= '0'& regwin(103*N-1 downto 103*N-N);
A24 <= '0'& regwin(104*N-1 downto 104*N-N);
A25 <= '0'& regwin(105*N-1 downto 105*N-N);

A31 <= '0'& regwin(201*N-1 downto 201*N-N);
A32 <= '0'& regwin(202*N-1 downto 202*N-N);
A33 <= '0'& regwin(203*N-1 downto 203*N-N);
A34 <= '0'& regwin(204*N-1 downto 204*N-N);
A35 <= '0'& regwin(205*N-1 downto 205*N-N);

A41 <= '0'& regwin(301*N-1 downto 301*N-N);
A42 <= '0'& regwin(302*N-1 downto 302*N-N);
A43 <= '0'& regwin(303*N-1 downto 303*N-N);
A44 <= '0'& regwin(304*N-1 downto 304*N-N);
A45 <= '0'& regwin(305*N-1 downto 305*N-N);

A51 <= '0'& regwin(401*N-1 downto 401*N-N);
A52 <= '0'& regwin(402*N-1 downto 402*N-N);
A53 <= '0'& regwin(403*N-1 downto 403*N-N);
A54 <= '0'& regwin(404*N-1 downto 404*N-N);
A55 <= '0'& regwin(405*N-1 downto 405*N-N);
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
sumout<=(others=>'0');
elsif rising_edge(clk) then
sumout<=M11+M12+M13+M14+M15+M21+M22+M23+M24+M25+M31+M32+M33+M34+M35+M41+M42+M43+M44+M45+M51+M52+M53+M54+M55;
end if;
end process;

--processo de comparação
process(clk,reset)

begin

if reset='1' then
pxout<=(others=>'0');
elsif rising_edge(clk) then
if sumout(N+3)='1' then
pxout<=(others=>'0');
elsif sumout > k1 then
pxout<=k1;
else
pxout<=sumout;
end if;
end if;

end process;
end Behavioral;
