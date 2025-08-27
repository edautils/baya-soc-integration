-- ****************************************************************************
-- ** Description: leon2Ahbram.vhd
-- ** Author:      The SPIRIT Consortium
-- ** Revision:    $Revision: 1.1 $
-- ** Date:        $Date: 2012/01/22 16:56:41 $
-- **
-- ** Copyright (c) 2008, 2009 The SPIRIT Consortium.
-- **
-- ** This work forms part of a deliverable of The SPIRIT Consortium.
-- **
-- ** Use of these materials are governed by the legal terms and conditions
-- ** outlined in the disclaimer available from www.spiritconsortium.org.
-- **
-- ** This source file is provided on an AS IS basis.  The SPIRIT
-- ** Consortium disclaims any warranty express or implied including
-- ** any warranty of merchantability and fitness for use for a
-- ** particular purpose.
-- **
-- ** The user of the source file shall indemnify and hold The SPIRIT
-- ** Consortium and its members harmless from any damages or liability.
-- ** Users are requested to provide feedback to The SPIRIT Consortium
-- ** using either mailto:feedback@lists.spiritconsortium.org or the forms at
-- ** http://www.spiritconsortium.org/about/contact_us/
-- **
-- ** This file may be copied, and distributed, with or without
-- ** modifications; this notice must be included on any copy.
-- ****************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity leon2Ahbram is
    generic ( abits : integer := 10;
              dbits : integer := 32);
    port (
        rst         : in  std_logic;
        clk         : in  std_logic;
        hsel_s      : in  std_ulogic;                         -- slave select
        haddr_s     : in  std_logic_vector(31 downto 0);      -- address bus (byte)
        hwrite_s    : in  std_ulogic;                         -- read/write
        htrans_s    : in  std_logic_vector(1 downto 0);       -- transfer type
        hsize_s     : in  std_logic_vector(2 downto 0);       -- transfer size
        hburst_s    : in  std_logic_vector(2 downto 0);       -- burst type
        hwdata_s    : in  std_logic_vector(dbits-1 downto 0);      -- write data bus
        hprot_s     : in  std_logic_vector(3 downto 0);       -- protection control
        hmastlock_s : in  std_ulogic;                         -- master lock
        hreadyi_s   : in  std_ulogic;                         -- transfer done
        hmaster_s   : in  std_logic_vector(3 downto 0);       -- current master
        hreadyo_s   : out std_ulogic;                         -- transfer done
        hresp_s     : out std_logic_vector(1 downto 0);       -- response type
        hrdata_s    : out std_logic_vector(dbits-1 downto 0);      -- read data bus
        hsplit_s    : out std_logic_vector(15 downto 0)       -- split completion
    );
end; 

