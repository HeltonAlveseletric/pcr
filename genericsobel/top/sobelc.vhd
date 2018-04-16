----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2018 13:18:54
-- Design Name: 
-- Module Name: sobelc - Behavioral
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

entity sobelc is
generic(N: integer:=8);
Port (reset: in std_logic;
      clk: in std_logic;
      selm:in std_logic;
      ink: in std_logic_vector(N-1 downto 0);--entrada de bits
      out1: out std_logic_vector(N+3 downto 0);
      ready1: out std_logic;
      ready2: out std_logic);
end sobelc;

architecture Behavioral of sobelc is
--componente demux
component demux2x1 is
generic (N: integer);
Port (in1:in std_logic_vector(N-1 downto 0);
      outa: out std_logic_vector(N-1 downto 0);
      outb: out std_logic_vector(N-1 downto 0);
      sel: in std_logic );
end component;
--componente Gx
component filtrosobel5x5g1
generic (N: integer);
Port (clk: in std_logic;--clock
      reset: in std_logic;--reset
      pxin: in std_logic_vector(N-1 downto 0);--pixel de entrada
      pxout: out std_logic_vector(N+3 downto 0);--pixel de saída
      ready: out std_logic);--ready
end component;
--componente Gy
component filtrosobel5x5g2 is
generic(N: integer);
Port (clk: in std_logic;--clock
      reset: in std_logic;--reset
      pxin: in std_logic_vector(N-1 downto 0);--pixel de entrada
      pxout: out std_logic_vector(N+3 downto 0);--pixel de saída
      ready: out std_logic);--ready
end component;
--componente mux2x1
component mux2x1 is
generic (N:integer);
    Port (a : in STD_LOGIC_VECTOR(N+3 downto 0);
           b : in STD_LOGIC_VECTOR (N+3 downto 0);
           sel : in STD_LOGIC;
           outk:out std_logic_vector(N+3 downto 0));
end component;
signal out7a: std_logic_vector(N-1 downto 0):=(others=>'0');--sinal para ligar o demux a ao Gx
signal out7b: std_logic_vector(N-1 downto 0):=(others=>'0');--sinal para ligar o demux ao Gy
signal outgx: std_logic_vector(N+3 downto 0):=(others=>'0');--sinal de saída de Gx
signal outgy: std_logic_vector(N+3 downto 0):=(others=>'0');--sinal de saída de Gy

begin
--ligando todo mundo
--ligando os itens ao demux
n1: demux2x1 
generic map(N=>8)
port map(
in1=>ink,
sel=>selm,
outa=>out7a,
outb=>out7b);
--ligando aos itens do Gx
n2: filtrosobel5x5g1 
generic map(N=>8)
port map(
clk=>clk,
reset=>reset,
pxin=>out7a,
pxout=>outgx,
ready=>ready1);
--ligando os itens ao Gy
n3: filtrosobel5x5g2 
generic map(N=>8)
port map(
clk=>clk,
reset=>reset,
pxin=>out7b,
pxout=>outgy,
ready=>ready2);
--ligando os itens ao mux
n4:mux2x1 
generic map(N=>8)
port map(
a=>outgx,
b=>outgy,
sel=>selm,
outk=>out1);
end Behavioral;
