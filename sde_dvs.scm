; =====================================================================
; Synopsys Sentaurus Structure Editor (sde) Geometry & Mesh Setup
; Project: Symmetric Double-Gate MOSFET (Silicon Channel with Si3N4)
; =====================================================================

; --- 1. GEOMETRY DEFINITION (Rectangles) ---
; Format: (position X1 Y1 Z1) (position X2 Y2 Z2) "Material" "Region_Name"

; Semiconductor Core (Source, Channel, Drain)
(sdegeo:create-rectangle (position 0.00  0.000 0) (position 0.03  0.010 0) "Silicon" "region_1_sr")
(sdegeo:create-rectangle (position 0.03  0.000 0) (position 0.07  0.010 0) "Silicon" "region_2_ch")
(sdegeo:create-rectangle (position 0.07  0.000 0) (position 0.10  0.010 0) "Silicon" "region_3_dr")

; Top and Bottom Gate Dielectrics (Silicon Nitride)
(sdegeo:create-rectangle (position 0.03  0.010 0) (position 0.07  0.013 0) "Si3N4"   "region_4_o1")
(sdegeo:create-rectangle (position 0.03 -0.003 0) (position 0.07  0.000 0) "Si3N4"   "region_5_o2")

; Top and Bottom Gates (Polysilicon Contacts)
(sdegeo:create-rectangle (position 0.03  0.013 0) (position 0.07  0.017 0) "PolySi"  "region_6_g1")
(sdegeo:create-rectangle (position 0.03 -0.007 0) (position 0.07 -0.003 0) "PolySi"  "region_7_g2")


; --- 2. DOPING PROFILE PLACEMENTS ---

; Source Doping: n-type Arsenic heavily doped (1e20 cm^-3)
(sdedr:define-constant-profile "ConstantProfileDefinition_1" "ArsenicActiveConcentration" 1e20)
(sdedr:define-constant-profile-region "ConstantProfilePlacement_1" "ConstantProfileDefinition_1" "region_1_sr")

; Drain Doping: n-type Arsenic heavily doped (1e20 cm^-3)
(sdedr:define-constant-profile "ConstantProfileDefinition_2" "ArsenicActiveConcentration" 1e+20)
(sdedr:define-constant-profile-region "ConstantProfilePlacement_2" "ConstantProfileDefinition_2" "region_3_dr")

; Channel Doping: p-type Boron lightly doped (1e16 cm^-3)
(sdedr:define-constant-profile "ConstantProfileDefinition_3" "BoronActiveConcentration" 1e+16)
(sdedr:define-constant-profile-region "ConstantProfilePlacement_3" "ConstantProfileDefinition_3" "region_2_ch")


; --- 3. MESH REFINEMENT DEFINITIONS ---
; Defines a tight 0.002 x 0.002 mesh step size for clear carrier resolution

(sdedr:define-refinement-size "RefinementDefinition_1" 0.002 0.002 0.002 0.002)
(sdedr:define-refinement-placement "RefinementPlacement_1" "RefinementDefinition_1" (list "region" "region_1_sr"))

(sdedr:define-refinement-size "RefinementDefinition_2" 0.002 0.002 0.002 0.002)
(sdedr:define-refinement-placement "RefinementPlacement_2" "RefinementDefinition_2" (list "region" "region_3_dr"))

(sdedr:define-refinement-size "RefinementDefinition_3" 0.002 0.002 0.002 0.002)
(sdedr:define-refinement-placement "RefinementPlacement_3" "RefinementDefinition_3" (list "region" "region_2_ch"))


; --- 4. CONTACT ALLOCATIONS ---

; Declare Contact Set Name Strings
(sdegeo:define-contact-set "sr" 4 (color:rgb 1 0 0) "##")
(sdegeo:define-contact-set "ch" 4 (color:rgb 1 0 0) "##")
(sdegeo:define-contact-set "dr" 4 (color:rgb 1 0 0) "##")

; Set Active Flags
(sdegeo:set-current-contact-set "sr")
(sdegeo:set-current-contact-set "ch")
(sdegeo:set-current-contact-set "dr")

; Bind contacts to specific boundary edges using spatial coordinate targeting
(sdegeo:set-contact (list (car (find-edge-id (position 0.00  0.005 0)))) "sr") ; Left border edge
(sdegeo:set-contact (list (car (find-edge-id (position 0.05  0.017 0)))) "ch") ; Top Gate surface
(sdegeo:set-contact (list (car (find-edge-id (position 0.05 -0.007 0)))) "ch") ; Bottom Gate surface
(sdegeo:set-contact (list (car (find-edge-id (position 0.10  0.005 0)))) "dr") ; Right border edge


; --- 5. MESH GENERATION & VISUALIZATION ---
(sde:set-meshing-command "snmesh")
(sde:build-mesh "" "sde_dvs")
(system:command "svisual sde_dvs_msh.tdr &")
