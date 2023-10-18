import common
import re

def FullOTA_InstallEnd(info):
  OTA_InstallEnd(info)
  return

def IncrementalOTA_InstallEnd(info):
  OTA_InstallEnd(info)
  return

def AddImage(info, name, dest, firmware):
  AddImageToZIP(info, name, firmware)
  info.script.AppendExtra('package_extract_file("%s", "%s");' % (name, dest))

def AddImageToZIP(info, name, firmware):
  if firmware:
    data = info.input_zip.read("RADIO/" + name)
  else:
    data = info.input_zip.read("IMAGES/" + name)
  common.ZipWriteStr(info.output_zip, name, data)

def PackageExtractFile(info, name, dest):
  info.script.AppendExtra('package_extract_file("%s", "%s");' % (name, dest))

def PackageExtractFile_Preloader(info, name, dest, is_emmc):
  if is_emmc:
    info.script.AppendExtra("""assert(set_emmc_writable("/sys/block/%s/force_ro"),
        package_extract_file("%s", "/dev/block/%s"));""" % (dest, name, dest))
  else:
    info.script.AppendExtra('assert(package_extract_file("%s", "/dev/block/%s"));' % (name, dest))

def SwitchActive(info, a, b):
  info.script.AppendExtra('switch_active("%s", "%s");' % (a, b))

def ShowMTUpdateStage(info):
  info.script.AppendExtra('show_mtupdate_stage("/cache/recovery/last_mtupdate_stage");')

def SetMTUpdateStage(info, value):
  info.script.AppendExtra('set_mtupdate_stage("/cache/recovery/last_mtupdate_stage", "%s");' % value)

def DeleteMTUpdateStage(info):
  info.script.AppendExtra('delete("/cache/recovery/last_mtupdate_stage");')

def OTA_InstallEnd(info):
  AddImageToZIP(info, "lk.img", True)
  AddImageToZIP(info, "md1img.img", True)
  AddImageToZIP(info, "preloader_emmc.img", True)
  AddImageToZIP(info, "preloader_raw.img", True)
  AddImageToZIP(info, "preloader_ufs.img", True)
  AddImageToZIP(info, "scp.img", True)
  AddImageToZIP(info, "spmfw.img", True)
  AddImageToZIP(info, "sspm.img", True)
  AddImageToZIP(info, "tee.img", True)

  Firmware_Images(info)
  return

def Firmware_Images(info):

  ShowMTUpdateStage(info)

  info.script.AppendExtra('ifelse (')
  info.script.AppendExtra('less_than_int(get_mtupdate_stage("/cache/recovery/last_mtupdate_stage"), "1") ,')
  info.script.AppendExtra('(')

  info.script.Print('start to update general image')

  AddImage(info, "dtbo.img", "/dev/block/platform/bootdevice/by-name/dtbo", False)
  # logo.bin
  PackageExtractFile(info, "md1img.img", "/dev/block/platform/bootdevice/by-name/md1img")
  PackageExtractFile(info, "spmfw.img", "/dev/block/platform/bootdevice/by-name/spmfw")

  SetMTUpdateStage(info, "1")

  info.script.AppendExtra('),')

  info.script.Print('general images are already updated')

  info.script.AppendExtra(');')

  info.script.AppendExtra('ifelse (')
  info.script.AppendExtra('less_than_int(get_mtupdate_stage("/cache/recovery/last_mtupdate_stage"), "3") ,')
  info.script.AppendExtra('(')
  info.script.AppendExtra('if less_than_int(get_mtupdate_stage("/cache/recovery/last_mtupdate_stage"), "2") then')

  info.script.Print('start to update alt loader image')

  PackageExtractFile(info, "sspm.img", "/dev/block/platform/bootdevice/by-name/sspm_2")
  PackageExtractFile(info, "tee.img", "/dev/block/platform/bootdevice/by-name/tee2")
  PackageExtractFile(info, "scp.img", "/dev/block/platform/bootdevice/by-name/scp2")
  PackageExtractFile(info, "lk.img", "/dev/block/platform/bootdevice/by-name/lk2")

  info.script.AppendExtra('if get_storage_type() then')

  PackageExtractFile_Preloader(info, "preloader_ufs.img", "mmcblk0boot1", False)

  info.script.AppendExtra('else')
  
  PackageExtractFile_Preloader(info, "preloader_emmc.img", "mmcblk0boot1", True)
  
  info.script.AppendExtra('endif;')

  SetMTUpdateStage(info, "2")

  info.script.AppendExtra('endif;')

  info.script.AppendExtra('')

  SwitchActive(info, "sspm_1", "sspm_2")
  SwitchActive(info, "tee1", "tee2")
  SwitchActive(info, "scp1", "scp2")
  SwitchActive(info, "lk", "lk2")
  SwitchActive(info, "preloader", "preloader2")

  SetMTUpdateStage(info, "3")

  info.script.AppendExtra('),')

  info.script.Print('alt loader images are already updated')

  info.script.AppendExtra(');')

  info.script.AppendExtra('ifelse (')
  info.script.AppendExtra('less_than_int(get_mtupdate_stage("/cache/recovery/last_mtupdate_stage"), "5") ,')
  info.script.AppendExtra('(')
  info.script.AppendExtra('if less_than_int(get_mtupdate_stage("/cache/recovery/last_mtupdate_stage"), "4") then')

  info.script.Print('start to update main loader image')

  PackageExtractFile(info, "sspm.img", "/dev/block/platform/bootdevice/by-name/sspm_1")
  PackageExtractFile(info, "tee.img", "/dev/block/platform/bootdevice/by-name/tee1")
  PackageExtractFile(info, "scp.img", "/dev/block/platform/bootdevice/by-name/scp1")
  PackageExtractFile(info, "lk.img", "/dev/block/platform/bootdevice/by-name/lk")

  info.script.AppendExtra('if get_storage_type() then')

  PackageExtractFile_Preloader(info, "preloader_ufs.img", "mmcblk0boot0", False)

  info.script.AppendExtra('else')
  
  PackageExtractFile_Preloader(info, "preloader_emmc.img", "mmcblk0boot0", True)
  
  info.script.AppendExtra('endif;')

  SetMTUpdateStage(info, "4")

  info.script.AppendExtra('endif;')

  info.script.AppendExtra('')

  SwitchActive(info, "sspm_2", "sspm_1")
  SwitchActive(info, "tee2", "tee1")
  SwitchActive(info, "scp2", "scp1")
  SwitchActive(info, "lk2", "lk")
  SwitchActive(info, "preloader2", "preloader")

  info.script.AppendExtra('),')

  info.script.Print('main loader images are already updated')

  info.script.AppendExtra(');')

  DeleteMTUpdateStage(info)

  AddImage(info, "vbmeta_system.img", "/dev/block/platform/bootdevice/by-name/vbmeta_system", False)
  AddImage(info, "vbmeta.img", "/dev/block/platform/bootdevice/by-name/vbmeta", False)
  AddImage(info, "vbmeta_vendor.img", "/dev/block/platform/bootdevice/by-name/vbmeta_vendor", False)
  return