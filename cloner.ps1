function cloneMyVM($originalVM, $snapshotName, $newVMName){
  try{
    Write-Host "Cloning from: $originalVM"
    Write-Host "Using snapshot: $snapshotName"
    Write-Host "New VM will be: $newVMName"
    $sourceVM = Get-VM -Name $originalVM
    $snap = Get-Snapshot -VM $sourceVM -Name $snapshotName
    $hostMachine = Get-VMHost -Name "192.168.7.20"
    $datastore = Get-DataStore -Name "datastore1"
    $cloneName = "{0}.linked" -f $sourceVM.name
    $linkedVM = New-VM -LinkedClone -Name $cloneName -VM $sourceVM -ReferenceSnapshot $snap -VMHost $hostMachine -Datastore $datastore
    $brandNewVM = New-VM -Name "$newVMName.base" -VM $linkedVM -VMHost $hostMachine -Datastore $datastore
    $brandNewVM | New-Snapshot -Name "Base"
    $linkedVM | Remove-VM -Confirm:$false
  }
  catch {
    Write-Host "Whoops, something went wrong!"
    exit
  }
}

# Now let's clone some VMs with a bit of flair!
#cloneMyVM -originalVM "480-fw" -snapshotName "Base-vyos-fw" -newVMName "480-fw-2"
#cloneMyVM -originalVM "xubuntu-wan" -snapshotName "Base-xubuntu" -newVMName "xubuntu-wan-2"



$linkedClone = "{0}.linked" -f $vm.name
$linkedClone
$linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds


$newvm = New-VM -Name "server.2019.gui.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds
$newvm
$newvm | New-Snapshot -Name "Base"
Get-VM
$linkedvm | Remove-VM
Get-VM


