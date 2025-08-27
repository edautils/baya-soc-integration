--
-- 
-- Revision:    $Revision: 1.1 $
-- Date:        $Date: 2012/01/22 16:56:41 $
-- 
-- Copyright (c) 2005, 2006, 2007, 2008, 2009 The SPIRIT Consortium.
-- 
-- This work forms part of a deliverable of The SPIRIT Consortium.
-- 
-- Use of these materials are governed by the legal terms and conditions
-- outlined in the disclaimer available from www.spiritconsortium.org.
-- 
-- This source file is provided on an AS IS basis.  The SPIRIT
-- Consortium disclaims any warranty express or implied including
-- any warranty of merchantability and fitness for use for a
-- particular purpose.
-- 
-- The user of the source file shall indemnify and hold The SPIRIT
-- Consortium and its members harmless from any damages or liability.
-- Users are requested to provide feedback to The SPIRIT Consortium
-- using either mailto:feedback@lists.spiritconsortium.org or the forms at 
-- http://www.spiritconsortium.org/about/contact_us/
-- 
-- This file may be copied, and distributed, with or without
-- modifications; this notice must be included on any copy.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
library std;
use Std.TextIO.all;

entity processor is
  generic (
      local_memory_start_addr : integer := 16#1000#;    -- upper 16 bits of address
      local_memory_addr_bits  : integer := 12;          -- number of address bits
      code_file               : string  := "master.tbl" -- file to read commands from
      );

port (
      -- Processor clock and reset
      rst_an:     in     std_logic;
      clk:        in     std_logic;
      clkn:       in     std_logic;

      -- AHB master
      hclk:       in     std_logic;
      hresetn:    in     std_logic;
      hready:     in     std_logic;
      hresp:      in     std_logic_vector(1 downto 0);
      haddr:      out    std_logic_vector(31 downto 0);
      hwrite:     out    std_logic;
      hsize:      out    std_logic_vector(2 downto 0);
      htrans:     out    std_logic_vector(1 downto 0);
      hburst:     out    std_logic_vector(2 downto 0);
      hprot:      out    std_logic_vector(3 downto 0);
      hwdata:     out    std_logic_vector(31 downto 0);
      hrdata:     in     std_logic_vector(31 downto 0);
      hgrant:     in     std_logic;
      hbusreq:    out    std_logic;

      -- APB slave
      pclk:       in     std_logic;
      presetn:    in     std_logic;
      paddr:      in     std_logic_vector(11 downto 0);  -- 512 bytes
      psel:       in     std_logic;
      penable:    in     std_logic;
      pwrite:     in     std_logic;
      prdata:     out    std_logic_vector(31 downto 0);
      pwdata:     in     std_logic_vector(31 downto 0);
      

      -- Interrupts
      irl:         in     std_logic_vector(3 downto 0);
      irqvec:      out    std_logic_vector(3 downto 0);
      intack:      out    std_logic;

      -- JTAG
      tck:         in     std_logic;
      ntrst:       in     std_logic;
      tms:         in     std_logic;
      tdi:         in     std_logic;
      tdo:         out    std_logic;

      -- Simulation signals
      SimDone:    out    std_logic
      );
end processor;
