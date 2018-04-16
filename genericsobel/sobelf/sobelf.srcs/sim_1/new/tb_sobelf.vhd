----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.03.2018 15:42:50
-- Design Name: 
-- Module Name: tb_filtroSobel3_3 - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2017 09:33:21
-- Design Name: 
-- Module Name: tb_sobel2 - Behavioral
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
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.numeric_std.all

entity tb_sobelf is
generic(N:integer:=8);
--  Port ( );
end tb_sobelf;

architecture Behavioral of tb_sobelf is

--FILE input_file  : text OPEN read_mode IS sim_file;
signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal pxin : std_logic_vector(N-1 downto 0) := (others=>'0');
signal pxout : std_logic_vector(N+3 downto 0) := (others=>'0');
signal enable : std_logic := '0';
signal ready1 : std_logic := '0';
signal ready2 : std_logic := '0';
signal sel : std_logic := '0';
-- conter for WOMenable
signal WOMenable : std_logic := '0';
signal cnt_ena : integer range 1 to 407 := 1;

component sobelc is
Port (reset: in std_logic;
      clk: in std_logic;
      selm:in std_logic;
      ink: in std_logic_vector(N-1 downto 0);--entrada de bits
      out1: out std_logic_vector(N+3 downto 0);
      ready1: out std_logic;
      ready2: out std_logic);
end component;

-- enderecamento das memorias ROM e WOM
signal ROMaddress : std_logic_vector(13 downto 0) := (others=>'0');

begin
   
    -- sinal de seleção
    
    sel<='1';
    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    
    -- clock generator
    clk <= not clk after 5 ns; 

    -- sobel architecture intanciation                    
    uut: sobelc port map(
        reset => reset,
        clk => clk,
        ink => pxin,
        out1 => pxout,
        ready1 => ready1,
        selm=>sel,
        ready2=>ready2); 

    read_from_file: process
    file infile	: text is in "tape.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(N-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
            readline(infile, inline);
            read(inline,dataf);
            pxin <= dataf;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
    
    WOMenable <= ready1 or ready2;
    
    write_to_file : process(clk) 
    variable out_line : line;
    file out_file     : text is out "res_tape1.txt";
    begin
        -- write line to file every clock
        if (rising_edge(clk)) then
            if WOMenable = '1' then
                write (out_line, pxout);
                writeline (out_file, out_line);
            end if; 
        end if;  
    end process ;

end Behavioral;