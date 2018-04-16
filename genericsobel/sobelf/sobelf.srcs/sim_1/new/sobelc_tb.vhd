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

entity sobelc_tb is
generic(N:integer);
-- Port ( );
end sobelc_tb;

architecture Behavioral of filtrosobel5x5g2_tb is

--FILE input_file  : text OPEN read_mode IS sim_file;
signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal pxin : std_logic_vector(N-1 downto 0) := (others=>'0');
signal pxout : std_logic_vector(N+3 downto 0) := (others=>'0');
signal enable : std_logic := '0';
signal ready : std_logic := '0';
-- conter for WOMenable
signal WOMenable : std_logic := '0';
signal cnt_ena : integer range 1 to 407 := 1;

component filtrosobel5x5g2 is
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       pxin : in STD_LOGIC_VECTOR (N-1 downto 0);
       pxout : out STD_LOGIC_VECTOR (N+3 downto 0);
       ready : out STD_LOGIC);
end component;

-- enderecamento das memorias ROM e WOM
signal ROMaddress : std_logic_vector(13 downto 0) := (others=>'0');

begin
   N<=8;
    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    
    -- clock generator
    clk <= not clk after 5 ns; 

    -- sobel architecture intanciation                    
    uut: filtrosobel5x5g2 port map(
        reset => reset,
        clk => clk,
        pxin => pxin,
        pxout => pxout,
        ready => ready); 

    read_from_file: process
    file infile	: text is in "tape1.txt"; -- input file declaration
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
    
    WOMenable <= ready;
    
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