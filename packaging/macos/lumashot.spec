# -*- mode: python ; coding: utf-8 -*-
import os
from PyInstaller.utils.hooks import collect_data_files


tcl_tk_data = collect_data_files('tkinter')

a = Analysis(
    ['../../lumashot/main.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('../../lumashot/resources/images/wallpapers/hires', 'resources/images/wallpapers/hires'),
        ('../../lumashot/resources/icons/lumashot.ico', 'resources/icons/'),
        *tcl_tk_data,
    ],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='lumashot',
    debug=False,
    bootloader_ignore_signals=False,
    strip=True,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon="../../lumashot/resources/icons/lumashot.ico"
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='lumashot',
)
