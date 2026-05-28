 File {
    Grid = "sde_dvs_msh.tdr"

    Parameter="sdevice.par"

    Current = "dgmos13"

    Plot = "dgmos13"

    Output = "dgmos13"

}
Electrode{

{Name="sr" voltage=0}

{Name="dr" voltage=1}

{Name="ch" voltage=-0.5 Workfunction=4.2}
}

Physics{

Fermi

EffectiveIntrinsicDensity(OldSlotboom)

Mobility(
   DopingDependence
   Enormal
)

Recombination(
   SRH(DopingDependence)
)

}
Plot{

   eDensity hDensity

   TotalCurrent/Vector eCurrent/Vector hCurrent/Vector

   eMobility hMobility

   eVelocity hVelocity

   Potential SpaceCharge

   ElectrostaticPotential

   ElectricField/Vector

   Doping DonorConcentration AcceptorConcentration

   SRH Auger

   Band2Band

   AvalancheGeneration eAvalancheGeneration hAvalancheGeneration

   BandGap

   EffectiveBandGap

   BandGapNarrowing

   Affinity

   ConductionBand ValenceBand
}


Math{

   RelErrControl

   Digits=5

   ErRef(electron)=1.e10

   ErRef(hole)=1.e10

   Notdamped=160

   Iterations=500

   DirectCurrent

   Method=ILS

}

Solve{

  Coupled(Iterations=1000){ Poisson }

  Coupled{ Poisson Electron Hole }

  Quasistationary(

    MinStep=1e-6 MaxStep=0.01

    Goal{ Name="ch" Voltage=1.5}

  ){ Coupled{ Poisson Electron Hole } }

}
