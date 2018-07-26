$VM = $args[0]
$CPU = $args[1]
$RAM = $args[2]

new-item "D:\$VM" -itemtype directory
new-item "D:\$VM\Virtual Hard Disks" -itemtype directory
$Path = "D:\" + $VM
$Source = 'E:\ExportVM\template_Ubuntu16.04LTS\Virtual Machines\4FF43B50-9B07-48CD-9335-E219BE9711ED.vmcx'
$Import = Import-VM -Path $Source -Copy -GenerateNewId -VirtualMachinePath $Path -VhdDestinationPath "D:\$VM\Virtual Hard Disks" -SnapshotFilePath $Path
Foreach ($Import in $Import)
{
    $oldName = $Import.Name
    Rename-VM $oldName -NewName $VM
}

SET-VMProcessor -VMname $VM -count $CPU
Set-VMMemory $VM -StartupBytes $RAM

Start-VM -Name $VM
