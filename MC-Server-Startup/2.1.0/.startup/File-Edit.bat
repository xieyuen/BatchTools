:: File Edit

:: �����ת
if %0=="Config" goto :Config
if %0=="Config_Save" set "_exit=true" & goto :Config_Save
if %0=="Mods_Plgs" goto :Modify_MODs_PLGs

:: �����ļ�
:Config

    if exist .\.startup if exist .\.startup\File-Edit.bat (
        cd .\.startup\
    ) else (
        if exist *.jar cd ../.startup
    )
    echo Ŀǰ������: 
    echo.
    echo ����������: %_Server%
    echo ��������С�ڴ�ռ��: %_RAMmin% MB
    echo ����������ڴ�ռ��: %_RAMmin% MB
    echo Java ·��("java" ��Ĭ��Java): %_Java%
    :: echo ����˹���·����%_Server_Working%
    echo.
    echo ��ѡ�����:
    echo [1]��������
    echo [2]��������
    echo [9]��ȡ����
    echo [0]��������������
    choice /C:1902 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :Config_Change
    if %_erl%==2 goto :Config_read
    if %_erl%==3 cls & call main.bat
    if %_erl%==4 goto :Config_Save

    :Config_Change

        echo ������Ŀ: 
        echo [1]����������
        echo [2]��������С�ڴ�ռ��
        echo [3]����������ڴ�ռ��
        echo [4]Java·��
        echo [5]EULA�Ƿ�ͬ��
        choice /N /C:12345
        set _erl=%ERRORLEVEL%
        if %_erl%==1 (
            
            :: ����������
            :Config_Change_Server
            echo ����������...
            echo.
            for %%i in ( *.jar ) do echo %%i
            echo.
            echo �������������: 
            set /p "_Server=���������ģ�"
            cd ..\server\

            :: ѭ�����
            :while-Config_Change_Server-NotExistServer
            if not exist .\%_Server% (
                echo û���ҵ����� :��
                echo ����������.
                echo >��ʵ��������������и���ճ����
                set /p "_Server=���������ģ�"
                goto :while-Config_Change_Server-NotExistServer
            )
            

        ) else (

            if %_erl%==2 (

                :: ��������С�ڴ�ռ��
                :Config_Change_Min

                echo �������������С�ڴ�ռ��(��λ:MB,1GB=1024MB)
                set /p "_temp_RAMmin="

                :: GTR�Ǵ���
                if %_temp_RAMmin% GTR %_RAMmax% (
                    echo emmmm.....
                    echo ��С�ڴ������ڴ滹��
                    echo Ҫ����
                    echo [1]�����
                    echo [2]����С
                    echo [3]��ԭ����
                    echo [4]��Ĭ�ϵ�
                    choice /N /C:1234
                    set _erl=%ERRORLEVEL%
                    if %_erl%==1 (
                        goto :Config_Change_Max
                    ) else (
                        if %_erl%==2 (
                            goto :Config_Change_Min
                        ) else (
                            if %_erl%==3 (
                                goto :if_exit-Config_Change_Min-MinMoreThanMax
                            ) else (
                                if %_erl%==4 (
                                    set _RAMmin=0
                                )
                            )
                        )
                    )
                ) else (
                    set "_RAMmin=%_temp_RAMmin%"
                )
                :if_exit-Config_Change_Min-MinMoreThanMax

            ) else (

                if %_erl%==3 (
                    
                    :: ����������ڴ�ռ��
                    :Config_Change_Max

                    echo ���������������ڴ�ռ��(��λ:MB,1GB=1024MB)
                    set /p "_temp_RAMmax="
                    :: GTR�Ǵ���
                    if %_temp_RAMmin% GTR %_RAMmax% (
                        echo emmmm.....
                        echo ��С�ڴ������ڴ滹��
                        echo Ҫ����
                        echo [1]�����
                        echo [2]����С
                        echo [3]��ԭ����
                        echo [4]��Ĭ�ϵ�
                        choice /N /C:1234
                        set _erl=%ERRORLEVEL%
                        if %_erl%==1 (
                            goto :Config_Change_Max
                        ) else (
                            if %_erl%==2 (
                                goto :Config_Change_Min
                            ) else (
                                if %_erl%==3 (
                                    goto :if_exit-Config_Change_Max-MinMoreThanMax
                                ) else (
                                    if %_erl%==4 (
                                        set _RAMmax=2048
                                    )
                                )
                            )
                        )
                    ) else (
                        set "_RAMmin=%_temp_RAMmin%"
                    )
                    :if_exit-Config_Change_Max-MinMoreThanMax

                ) else (

                    if %_erl%==4 (

                        :: Java·��
                        :Config_Change_Java
                        :: ����Java
                        echo �����������õ�Java...
                        echo.
                        echo java
                        for %%i in ( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ) do (
                            if exist %%i:\ (
                                :: ��|�� �������ǹܵ�����
                                dir /b /s %%i:\ | find "java.exe"
                            )
                        )
                        :: if exist D:\ (dir /b /s D:\ | find "java.exe")
                        :: if exist E:\ (dir /b /s E:\ | find "java.exe")
                        :: if exist F:\ (dir /b /s F:\ | find "java.exe")
                        :: if exist G:\ (dir /b /s G:\ | find "java.exe")
                        echo.
                        echo ������ɣ�
                        echo һ��һ��Java, �ɸ���(��java����Ĭ��Java)
                        echo ������Java·��: 
                        set /p "_temp_Java=Java·����"
                        :while-Config_Change_Java-NotExistJava
                        if not %_temp_Java%==java (
                            if not exist %_temp_Java% (
                                echo û���ҵ�Java :��
                                echo ����������.(����Ը���ճ����)
                                set /p "_temp_Java=Java·����"
                                goto :while-Config_Change_Java-NotExistJava
                            )
                        )

                    ) else (

                        if %_erl%==5 (
                            pass
                        )

                    )
                )
            )
        )
        echo.
        echo �������!
        echo ������...
         
    :Config_Save

        :: ��һ�δ����Ǳ��������ļ��Ĵ���
        :: >>config.bat �� >config.bat ����д�������ļ���
        :: ^^^^^^^^^^^^    ^^^^^^^^^^^
        ::   �����           �����
        ::  ���������        ����д��
        ::
        :: 'echo.' ��Ϊ����
        :: ����Ч���� README ��ʾ
        :: README����: https://github.com/xieyuen/Tool-Gallery/tree/main/MC-Server-Startup#%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
        echo @rem ���ǿ����ű��������ļ�>config.bat
        echo @rem ÿ�α��涼�Ḳ�ǵ��������ַ�>>config.bat
        echo @rem ��Ҫ�Ҹ�Ŷ���ر��� �� = �� ǰ��ģ�>>config.bat
        echo @rem Ҫ��Ҳֻ�ܸ�ÿ�� ��=�� �����>>config.bat
        echo. >>config.bat
        echo @rem ������������>>config.bat
        echo set _Server=%_Server%>>config.bat
        echo. >>config.bat
        echo @rem ����ڴ�ռ��, ��λMB>>config.bat
        echo set _RAMmax=%_RAMmax%>>config.bat
        echo. >>config.bat
        echo @rem ��С�ڴ�ռ��, ��λMB>>config.bat
        echo set _RAMmin=%_RAMmin%>>config.bat
        echo. >>config.bat
        echo @rem Java·��>>config.bat
        echo set "_Java=%_Java%">>config.bat
        echo. >>config.bat
        echo @rem EULA�Ƿ�ͬ��>>config.bat
        echo @rem ͬ�� true>>config.bat
        echo @rem ��ͬ�� false>>config.bat
        echo set "_eula=%_eula%">>config.bat
        echo. >>config.bat
        :: echo @rem ����˹���·��>>config.bat
        :: echo set "_Server_Working=%_Server_Working%">>config.bat

        if %_exit%==true echo The configuration file has been generated, please fill it in before running the script. The configuration file has been placed under the ".startup" folder and named "config.bat"

        echo ����ɹ�
        pause >nul
        goto :Config

    :Config_read

        if not exist config.bat (
            echo δʶ�������ļ�, 
            echo �밴���������...
            pause >nul
        ) else (
            echo ���ڶ�ȡ...
            call config.bat
            echo ��ȡ���!
        )
        goto :Config

