function Clone-MyVM {
    param(
        [string]$originalVM,
        [string]$snapshotName,
        [string]$newVMName
    )

    try {
        Write-Host "Alright, let's get started! 🎉"
        Write-Host "Cloning from: $originalVM"
        Write-Host "Using snapshot: $snapshotName"
        Write-Host "New VM will be: $newVMName"

        # Fetch the original VM and snapshot details
        $sourceVM = Get-VM -Name $originalVM
        $snap = Get-Snapshot -VM $sourceVM -Name $snapshotName
        # Assuming a specific host and datastore for the clone
        $hostMachine = Get-VMHost -Name "192.168.7.20"
        $datastore = Get-Datastore -Name "datastore1"

        # Creating a linked clone from the snapshot
        $cloneName = "{0}.linked" -f $sourceVM.Name
        $linkedVM = New-VM -LinkedClone -Name $cloneName -VM $sourceVM -ReferenceSnapshot $snap -VMHost $hostMachine -Datastore $datastore
        
        # Creating a new VM from the linked clone
        $brandNewVM = New-VM -Name "$newVMName.base" -VM $linkedVM -VMHost $hostMachine -Datastore $datastore
        $brandNewVM | New-Snapshot -Name "Base"

        # Cleanup the linked clone
        $linkedVM | Remove-VM -Confirm:$false

        Write-Host "Your new VM, $newVMName, is ready to go! 🚀"
    }
    catch {
        Write-Host "Uh oh, ran into a snag! 🚨" -ForegroundColor Red
        exit
    }
}

# Example usage:
# Clone-MyVM -originalVM "DC1" -snapshotName "Base-Snapshot" -newVMName "DC1-Clone"
# Clone-MyVM -originalVM "xubuntu-wan" -snapshotName "Prep-Complete" -newVMName "xubuntu-wan-clone"
