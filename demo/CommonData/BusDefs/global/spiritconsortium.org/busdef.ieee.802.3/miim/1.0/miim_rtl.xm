<?xml version="1.0" encoding="UTF-8"?>
<!-- 
// Description : mim.xml
// Author : SPIRIT Schema Working Group
// Version: 1.2
// 
// Revision:    $Revision: 1.1 $
// Date:        $Date: 2014/12/27 22:45:50 $
// 
// Copyright (c) 2006, 2008 The SPIRIT Consortium.
// 
// This work forms part of a deliverable of The SPIRIT Consortium.
// 
// Use of these materials are governed by the legal terms and conditions
// outlined in the disclaimer available from www.spiritconsortium.org.
// 
// This source file is provided on an AS IS basis.  The SPIRIT
// Consortium disclaims any warranty express or implied including
// any warranty of merchantability and fitness for use for a
// particular purpose.
// 
// The user of the source file shall indemnify and hold The SPIRIT
// Consortium and its members harmless from any damages or liability.
// Users are requested to provide feedback to The SPIRIT Consortium
// using either mailto:feedback@lists.spiritconsortium.org or the forms at 
// http://www.spiritconsortium.org/about/contact_us/
// 
// This file may be copied, and distributed, WITHOUT
// modifications; this notice must be included on any copy.
--><spirit:abstractionDefinition xmlns:spirit="http://www.spiritconsortium.org/XMLSchema/SPIRIT/1.4"
                              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                              xsi:schemaLocation="http://www.spiritconsortium.org/XMLSchema/SPIRIT/1.4                 http://www.spiritconsortium.org/XMLSchema/SPIRIT/1.4/index.xsd">
   <spirit:vendor>spiritconsortium.org</spirit:vendor>
   <spirit:library>busdef.ieee.802.3</spirit:library>
   <spirit:name>miim_rtl</spirit:name>
   <spirit:version>1.0</spirit:version>
   <spirit:busType spirit:vendor="spiritconsortium.org" spirit:library="busdef.ieee.802.3"
                   spirit:name="miim"
                   spirit:version="1.0"/>
   <spirit:ports>
		    <spirit:port>
         <spirit:logicalName>MDIO</spirit:logicalName>
         <spirit:wire>
            <spirit:onMaster>
               <spirit:width>1</spirit:width>
               <spirit:direction>inout</spirit:direction>
            </spirit:onMaster>
         </spirit:wire>
      </spirit:port>
		    <spirit:port>
         <spirit:logicalName>MDC</spirit:logicalName>
         <spirit:requiresDriver spirit:driverType="clock">true</spirit:requiresDriver>
         <spirit:wire>
            <spirit:qualifier>
               <spirit:isClock>true</spirit:isClock>
            </spirit:qualifier>
            <spirit:onSystem>
               <spirit:group>clock_reset_group</spirit:group>
               <spirit:width>1</spirit:width>
               <spirit:direction>out</spirit:direction>
            </spirit:onSystem>
            <spirit:onMaster>
               <spirit:width>1</spirit:width>
               <spirit:direction>in</spirit:direction>
            </spirit:onMaster>
         </spirit:wire>
      </spirit:port>
	  </spirit:ports>
</spirit:abstractionDefinition>