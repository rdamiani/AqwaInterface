:: Run all the FAST8+OrcaFlex examples

cd "MIT-NREL_TLP"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_MIT_NREL_TLP.fst

cd "..\OC3_Spar"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC3Hywind.fst

cd "..\OC4_LC_1.3a"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd "..\OC4_LC_1.3b"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd "..\OC4_LC_2.1"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd "..\OC4_LC_2.2"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd "..\OC4_LC_3.1"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd "..\OC4_LC_3.2"
start cmd /K ..\_Shared\FAST_x64.exe NRELOffshrBsline5MW_OC4DeepCwindSemi.fst
cd ".."

