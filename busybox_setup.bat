@echo off
chcp 65001 >nul
setlocal

rem ログファイル
set LOG=%USERPROFILE%\bin\busybox_setup.log

rem BusyBox 実行ファイルのパスと URL
set BB=%USERPROFILE%\bin\busybox.exe
set BIN=%USERPROFILE%\bin
set BBURL=https://frippery.org/files/busybox/busybox.exe

rem ログ開始
echo ==== %DATE% %TIME% ==== >> "%LOG%"
echo BusyBox セットアップ開始 >> "%LOG%"

rem bin ディレクトリがなければ作成
if not exist "%BIN%" (
    mkdir "%BIN%"
    echo bin ディレクトリを作成しました
    echo bin ディレクトリを作成しました >> "%LOG%"
) else (
    echo bin ディレクトリは既に存在します
    echo bin ディレクトリは既に存在します >> "%LOG%"
)

rem busybox.exe がなければダウンロード
if not exist "%BB%" (
    echo busybox.exe が存在しません。ダウンロード中…
    echo busybox.exe が存在しません。ダウンロード中… >> "%LOG%"
    powershell -Command "Invoke-WebRequest -Uri '%BBURL%' -OutFile '%BB%' -UseBasicParsing"
    if exist "%BB%" (
        echo ダウンロード終了
        echo ダウンロード終了 >> "%LOG%"
    ) else (
        echo ダウンロードに失敗しました
        echo ダウンロードに失敗しました >> "%LOG%"
        exit /b 1
    )
) else (
    echo busybox.exe は既に存在しました
    echo busybox.exe は既に存在しました >> "%LOG%"
)

rem BusyBox で利用可能な全コマンドを取得して HardLink 作成
for /f "tokens=*" %%c in ('"%BB%" --list') do (
    rem busybox.exe 自身はスキップ
    if /i not "%%c"=="busybox" (
        if exist "%BIN%\%%c.exe" (
            del "%BIN%\%%c.exe" >nul 2>&1
            echo %%c.exe の既存リンクを削除しました
            echo %%c.exe の既存リンクを削除しました >> "%LOG%"
        ) else (
            echo %%c.exe は存在しません
            echo %%c.exe は存在しません >> "%LOG%"
        )
        fsutil hardlink create "%BIN%\%%c.exe" "%BB%" >nul 2>&1
        echo %%c.exe を作成しました
        echo %%c.exe を作成しました >> "%LOG%"
    ) else (
        echo %%c.exe はスキップしました
        echo %%c.exe はスキップしました >> "%LOG%"
    )
)

rem binのパスを通す
setx PATH "%BIN%;%PATH%" >nul
echo PATH に %BIN% を追加しました
echo PATH に %BIN% を追加しました >> "%LOG%"

echo 全コマンド用 hardlink 作成完了！
echo 全コマンド用 hardlink 作成完了！ >> "%LOG%"

endlocal
