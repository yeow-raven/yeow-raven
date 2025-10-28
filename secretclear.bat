@echo off
title Pembersih File Sampah/Danishtzy24
color 0E

echo ===============================================
echo [ PERINGATAN EFEK MINOR ]
echo ===============================================
echo 1. Skrip ini AMAN dan TIDAK merusak data pribadi.
echo 2. PEMBERSIHAN MENDALAM: Skrip ini akan menghapus semua cache dan log lama.
echo 3. EFEK SEMENTARA: Loading aplikasi pertama kali mungkin sedikit lambat (Prefetch).
echo 4. PERLU DIPERHATIKAN: Menghapus cache update (DISM) berarti Anda tidak
echo    dapat mencopot pemasangan update Windows yang sudah terinstal.
echo ===============================================
echo.
echo Wajib jalankan Run as Administrator!
echo Pencet Enter buat lanjut atau Ctrl+C buat batalin.
pause >nul

setlocal EnableDelayedExpansion

:: Cek Hak Akses Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Gagal! Skrip HARUS dijalankan sebagai Administrator!
    echo Klik kanan file .bat lalu pilih "Run as Administrator".
    pause
    exit /b
)

echo ===============================================
echo   PEMBERSIH FILE SAMPAH WINDOWS - DIMULAI
echo   %date%  %time%
echo ===============================================
echo.

:: LANGKAH PEMBERSIHAN CACHE & LOG (1-7)
echo [1/11] Menghapus isi folder %%TEMP%% (User Temp) ...
rd /s /q "%TEMP%" 2>nul & mkdir "%TEMP%" >nul

echo [2/11] Menghapus isi folder C:\Windows\Temp (System Temp) ...
rd /s /q "C:\Windows\Temp" 2>nul & mkdir "C:\Windows\Temp" >nul

echo [3/11] Menghapus isi folder C:\Windows\Prefetch (Cache Kecepatan) ...
rd /s /q "C:\Windows\Prefetch" 2>nul & mkdir "C:\Windows\Prefetch" >nul

echo [4/11] Menghapus cache Windows Update (SoftwareDistribution\Download) ...
rd /s /q "C:\Windows\SoftwareDistribution\Download" 2>nul & mkdir "C:\Windows\SoftwareDistribution\Download" >nul

echo [5/11] Menghapus log Windows Servicing (C:\Windows\Logs\CBS) ...
rd /s /q "C:\Windows\Logs\CBS" 2>nul & mkdir "C:\Windows\Logs\CBS" >nul

echo [6/11] Menghapus Cache Instalasi Aplikasi Windows Store (AppRepository) ...
rd /s /q "C:\ProgramData\Microsoft\Windows\AppRepository" 2>nul & mkdir "C:\ProgramData\Microsoft\Windows\AppRepository" >nul

echo [7/11] Menghapus riwayat file yang baru dibuka (Recent Items) ...
del /f /s /q "%AppData%\Microsoft\Windows\Recent\*.*" 2>nul

:: LANGKAH PEMBERSIHAN FOLDER UPGRADE LAMA (8-9)
echo [8/11] Menghapus folder instalasi/upgrade lama C:\$Windows.~BT (Jika Ada) ...
rd /s /q "C:\$Windows.~BT" 2>nul

echo [9/11] Menghapus folder instalasi/upgrade lama C:\$GetCurrent (Jika Ada) ...
rd /s /q "C:\$GetCurrent" 2>nul

:: LANGKAH PEMBERSIHAN AKHIR (10-11)
echo.
echo [10/11] Membersihkan Komponen Update Windows Lama (DISM WinSxS Cleanup) ...
rem Proses ini mungkin memakan waktu beberapa menit.
Dism.exe /online /Cleanup-Image /StartComponentCleanup >nul

echo [11/11] Mengosongkan Recycle Bin dan Cache Ikon ...
del /f /s /q "%LocalAppData%\IconCache.db" 2>nul
PowerShell -Command "Clear-RecycleBin -Force" 2>nul

echo.
echo ===============================================
echo  Pembersihan Selesai Total!
echo  Semua sampah utama sistem telah dihapus.
echo ===============================================
pause
exit