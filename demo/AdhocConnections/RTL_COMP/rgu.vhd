-- Copyright (c) 2005, 2006, 2007, 2009 The SPIRIT Consortium.  All rights reserved.
-- www.spiritconsortium.org
--
-- THIS WORK FORMS PART OF A SPIRIT CONSORTIUM SPECIFICATION.
-- USE OF THESE MATERIALS ARE GOVERNED BY
-- THE LEGAL TERMS AND CONDITIONS OUTLINED IN THE SPIRIT
-- SPECIFICATION DISCLAIMER AVAILABLE FROM
-- www.spiritconsortium.org
--
-- This source file is provided on an AS IS basis. The SPIRIT Consortium disclaims 
-- ANY WARRANTY EXPRESS OR IMPLIED INCLUDING ANY WARRANTY OF
-- MERCHANTABILITY AND FITNESS FOR USE FOR A PARTICULAR PURPOSE. 
-- The user of the source file shall indemnify and hold The SPIRIT Consortium harmless
-- from any damages or liability arising out of the use thereof or the performance or
-- implementation or partial implementation of the schema.


-- SIMPLE RGU EXAMPLE. PRODUCES 8 RESET OUTPUTS, EACH HAS AN 8 BIT DELAY
-- REGISTER. THE DELAY IS THE NUMBER OF CLOCKS FROM WHEN THE RESET INPUT
-- IS DEASSERTED TILL THE RESET OUTPUT IS DEASSERTED. 8 OTHER REGISTERS
-- ARE USED AS NON_VOLITILE STORAGE INSIDE THE RGU
-- 4K byte addressSpace
--
-- reset(0) = read only delay at address 0x0
-- reset(1) = read only delay at address 0x4
-- reset(2) = read only delay at address 0x8
-- reset(3) = read only delay at address 0xC
-- reset(4) = read only delay at address 0x10
-- reset(5) = read only delay at address 0x14
-- reset(6) = read only delay at address 0x18
-- reset(7) = read only delay at address 0x1C
-- memory(0) = read/write register at address 0x20
-- memory(1) = read/write register at address 0x24
-- memory(2) = read/write register at address 0x28
-- memory(3) = read/write register at address 0x2C
-- memory(4) = read/write register at address 0x30
-- memory(5) = read/write register at address 0x34
-- memory(6) = read/write register at address 0x38
-- memory(7) = read/write register at address 0x3C
-- ...
--  
-- 0 = No Delay 
-- 1 = Delay by 1 clock
-- 2 = Delay by 2 clocks
-- 3 = Delay by 3 clocks
-- ...
--
-- read only ID register at 0xFFC = 0x00000D01


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Std_Logic_TEXTIO.all;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity rgu is

generic (
      delay0 : integer := 0;
      delay1 : integer := 1;
      delay2 : integer := 2;
      delay3 : integer := 4;
      delay4 : integer := 8;
      delay5 : integer := 16;
      delay6 : integer := 32;
      delay7 : integer := 64
      );

port (
      rstin_an:      in     std_logic;
      rstout_an:     out    std_logic_vector(7 downto 0);

      ipclk:      in     std_logic;  -- must be active while outputs are still reset

      pclk:       in     std_logic;
      presetn:    in     std_logic;
      paddr:      in     std_logic_vector(11 downto 0);
      pwrite:     in     std_logic;
      penable:    in     std_logic;
      psel:       in     std_logic;
      pwdata:     in     std_logic_vector(31 downto 0);
      prdata:     out    std_logic_vector(31 downto 0)
      );
end rgu;

