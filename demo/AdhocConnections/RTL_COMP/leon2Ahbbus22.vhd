-- 
-- Revision:    $Revision: 1.1 $
-- Date:        $Date: 2012/01/22 16:56:41 $
-- 
-- Copyright (c) 2007, 2008, 2009 The SPIRIT Consortium.
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
use IEEE.std_logic_1164.all;


entity leon2Ahbbus22 is
  generic (
      start_addr_slv0 : integer := 0;           -- upper 16 bits of address
      restart_addr_slv0 : integer := 0;           -- upper 16 bits of address
      range_slv0      : integer := 0;           -- range in bytes
      mst_access_slv0 : integer := 16#FFFF#;    -- bit mask for master access to this slave
      start_addr_slv1 : integer := 0;
      restart_addr_slv1 : integer := 0;
      range_slv1      : integer := 0;
      mst_access_slv1 : integer := 16#FFFF#;    -- bit mask for master access to this slave
      defmast         : integer := 1 		-- default master
  );

  port (
    rst            : in  std_logic;
    clk            : in  std_logic;

    remap          : in  std_logic;
    -- msti[0]
    hgrant_mst0    : out  Std_ULogic;                    -- bus grant
    hready_mst0    : out  Std_ULogic;                    -- transfer done
    hresp_mst0     : out  Std_Logic_Vector(1  downto 0); -- response type
    hrdata_mst0    : out  Std_Logic_Vector(31 downto 0); -- read data bus

    -- msti[1]
    hgrant_mst1    : out  Std_ULogic;                    -- bus grant
    hready_mst1    : out  Std_ULogic;                    -- transfer done
    hresp_mst1     : out Std_Logic_Vector(1  downto 0); -- response type
    hrdata_mst1    : out  Std_Logic_Vector(31 downto 0); -- read data bus

    -- msto[0]
    hbusreq_mst0   : in   Std_ULogic;                    -- bus request
    hlock_mst0     : in   Std_ULogic;                    -- lock request
    htrans_mst0    : in   Std_Logic_Vector(1  downto 0); -- transfer type 
    haddr_mst0     : in   Std_Logic_Vector(31 downto 0); -- address bus (byte)
    hwrite_mst0    : in   Std_ULogic;                    -- read/write
    hsize_mst0     : in   Std_Logic_Vector(2  downto 0); -- transfer size
    hburst_mst0    : in   Std_Logic_Vector(2  downto 0); -- burst type
    hprot_mst0     : in   Std_Logic_Vector(3  downto 0); -- protection control
    hwdata_mst0    : in   Std_Logic_Vector(31 downto 0); -- write data bus

    -- msto[1]
    hbusreq_mst1   : in   Std_ULogic;                    -- bus request
    hlock_mst1     : in   Std_ULogic;                    -- lock request
    htrans_mst1    : in   Std_Logic_Vector(1  downto 0); -- transfer type 
    haddr_mst1     : in   Std_Logic_Vector(31 downto 0); -- address bus (byte)
    hwrite_mst1    : in   Std_ULogic;                    -- read/write
    hsize_mst1     : in   Std_Logic_Vector(2  downto 0); -- transfer size
    hburst_mst1    : in   Std_Logic_Vector(2  downto 0); -- burst type
    hprot_mst1     : in   Std_Logic_Vector(3  downto 0); -- protection control
    hwdata_mst1    : in   Std_Logic_Vector(31 downto 0); -- write data bus

    -- slvi[0]
    hsel_slv0      : out   Std_ULogic;                         -- slave select
    haddr_slv0     : out   Std_Logic_Vector(31 downto 0);      -- address bus (byte)
    hwrite_slv0    : out   Std_ULogic;                         -- read/write
    htrans_slv0    : out   Std_Logic_Vector(1  downto 0);      -- transfer type
    hsize_slv0     : out   Std_Logic_Vector(2  downto 0);      -- transfer size
    hburst_slv0    : out   Std_Logic_Vector(2  downto 0);      -- burst type
    hwdata_slv0    : out   Std_Logic_Vector(31 downto 0);      -- write data bus
    hprot_slv0     : out   Std_Logic_Vector(3  downto 0);      -- protection control
    hreadyin_slv0  : out   Std_ULogic;                         -- transfer done
    hmaster_slv0   : out   Std_Logic_Vector(3  downto 0);      -- current master
    hmastlock_slv0 : out   Std_ULogic;                         -- locked access

    -- slvi[1]
    hsel_slv1      : out   Std_ULogic;                         -- slave select
    haddr_slv1     : out   Std_Logic_Vector(31 downto 0);      -- address bus (byte)
    hwrite_slv1    : out   Std_ULogic;                         -- read/write
    htrans_slv1    : out   Std_Logic_Vector(1  downto 0);      -- transfer type
    hsize_slv1     : out   Std_Logic_Vector(2  downto 0);      -- transfer size
    hburst_slv1    : out   Std_Logic_Vector(2  downto 0);      -- burst type
    hwdata_slv1    : out   Std_Logic_Vector(31 downto 0);      -- write data bus
    hprot_slv1     : out   Std_Logic_Vector(3  downto 0);      -- protection control
    hreadyin_slv1  : out   Std_ULogic;                         -- transfer done
    hmaster_slv1   : out   Std_Logic_Vector(3  downto 0);      -- current master
    hmastlock_slv1 : out   Std_ULogic;                         -- locked access

    -- slvo[0]
    hreadyout_slv0 : in    Std_ULogic;                         -- transfer done
    hresp_slv0     : in    Std_Logic_Vector(1  downto 0);      -- response type
    hrdata_slv0    : in    Std_Logic_Vector(31 downto 0);      -- read data bus
    hsplit_slv0    : in    Std_Logic_Vector(15 downto 0);      -- split completion

    -- slvo[1]
    hreadyout_slv1 : in    Std_ULogic;                         -- transfer done
    hresp_slv1     : in    Std_Logic_Vector(1  downto 0);      -- response type
    hrdata_slv1    : in    Std_Logic_Vector(31 downto 0);      -- read data bus
    hsplit_slv1    : in    Std_Logic_Vector(15 downto 0)      -- split completion
  );
end;

