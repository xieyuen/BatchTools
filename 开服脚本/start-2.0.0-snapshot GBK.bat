@echo off
@rem ����Ŀ��
@rem 1.���ı���ɫ!
@rem 2.�Ż�EULAЭ��
@rem  2.1.��ȡEULA����
@rem  2.2.�Զ�ͬ��EULA
@rem 3.������������Config�ļ�
::===========================================================================================================================
:: ����
set _version=2.0.0
if not exist config.bat (
   set "_ACS=AutoCheckingServer"
   :Initialize
      chcp 936 & :: ���ô���ҳ GBK
      set _RAMmax=4096
      set _RAMmin=0
      set _restart=0 & :: ������������
      set _error=0 & :: ����������ʾ����
      set "_Java=.\Java18\bin\java.exe" & :: ���� Java ·��
      set "_Frpc=.\MEFrp\frpc.exe"
      set "_Frpc_Config=.\MEFrp\Frpc.ini"
      :: �����޸�
      if exist eula.txt (
         set _eula=true 
      ) else ( 
         set _eula=false 
      )
   cls
) else (
   call config.bat
   set _config=true
)

::============================================================================================================================

:Welcome & ::��ӭ����
   title Hello! %username%, ��ӭʹ�ô˽ű�
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
   echo ��ӭ%username%ʹ�ô˽ű�!
   echo �ű��汾: %_version% snapshot GBK
   echo �˽ű�Ϊ���հ�, ��BUG������ xieyuen163@163.com
   echo.
   echo ��汾�������ʲôBUG�Ǿ���������ʽ���
   echo.
   echo --------------------------------------
   echo ������־:
   echo   ȥREADME.MD��(
   echo --------------------------------------
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++

:Main_Action_Center & :: �������Ľ���
   echo ��ѡ����Ŀ:
   echo   [1]��������������
   echo   [2]Frp��������[Under Development]
   echo   [9]�����ļ����[Under Development]
   echo   [0]�˳�
   choice /C:0129A /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto bye
   if %_erl%==2 goto Server_Action_Center
   if %_erl%==3 (
      cls 
      echo.
      echo This feature is under development!
      echo This feature is under development! 
      echo This feature is under development! 
      echo. 
      goto Main_Action_Center
   )
   if %_erl%==4 (
      cls 
      echo.
      echo This feature is under development! 
      echo This feature is under development! 
      echo This feature is under development! 
      echo.
      goto Main_Action_Center
   )
   if %_erl%==5 (
      set /p "_login.confirm="
      if "%_User.login.confirm%=login Admin" (
         set _User=Admin
         echo User: Admin
         echo Please enter you login password...
         set "_User.admin.loginpassword=" /p
         if %_User.admin.loginpassword%==%_version% (
            echo Login Successful!
            goto Admin_Action_Center
         ) else (
            echo WRONG PASSWORD!
            pause >nul
            exit /b
         )
      ) else (
         goto Main_Action_Center
      )
   )  

:Admin_Action_Center
   cls
   echo [1]Frp_Action_Center.
   echo [2]Config
   echo [0]exit
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Frp_Action_Center
   if %_erl%==2 goto Config
   if %_erl%==3 goto Main_Action_Center

:Frp_Action_Center
   cls
   echo �ű��ֽ�֧��MEfrp(��Եӳ��)!
   echo.
   echo  Frp��ǰ����:
   echo     frp·��:%_Frpc%
   echo     frp����·��:%_Frpc_Config%
   echo. 
   echo  ��ѡ�����:
   echo     [1]����frp
   echo     [2]����frp�����ű�
   echo     [0]��������������
   choice /C:012 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Main_Action_Center
   if %_erl%==2 goto Start_Frp
   if %_erl%==3 goto SaveFrp

:Server_Action_Center
   if not %_config%==true (
      if %_ACS%==AutoCheckingServer (
         set "%_ACS%=unAutoCheckingServer"
         goto AutoCheckingServer
      )
   )
   echo ��������ǰ����:
   echo   ����:%_Server% 
   echo   ����ڴ�ռ��:%_RAMmax%MB 
   echo   ��ʼ�ڴ�ռ��:%_RAMmin%MB
   echo   Java·��:%_Java%
   echo ��ѡ�����:
   echo   [1]����������
   echo   [2]��������������
   echo   [3]��������ڴ�ռ��
   echo   [4]������ʼ�ڴ�ռ��
   echo   [5]����/���ģ��Ͳ��
   echo   [6]����Java·��
   echo   [C]����
   echo   [0]��������������
   echo ����ѡ��Ĳ˵���:
   choice /C:0123456C /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Main_Action_Center
   if %_erl%==2 goto Choose
   if %_erl%==3 goto setServer
   if %_erl%==4 goto set_RAMmax
   if %_erl%==5 goto set_RAMmin
   if %_erl%==6 goto Modify_MODs_PLGs
   if %_erl%==7 goto Modify_Java
   if %_erl%==8 (
      cls
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   )

::============================================================================================================================

:bye
   cls
   echo ���Ҫ�뿪����?
   echo ��������᳷�����ѡ��
   echo [y]ȷ������
   echo [n]�װ�
   choice /C:YN /N
   set _erl=%ERRORLEVEL%
   cls
   if %_erl%==1 (
      echo Ү!
      goto Welcome
   )
   if %_erl%==2 (
      echo �װ�
      echo ����Թر����������
      echo ������㰴Щʲô
      pause >nul
      exit /b
   )

:Modify_Java
   echo ������Java·��:
   set /p "_Java="
   ::���Java·��������
   if exist %_Java% (
      echo ���óɹ�!
      goto Server_Action_Center
   )
   if exist "%_Java%\java.exe" (
      echo ���ƺ��Ǵ���Դ�������ϸ��Ƶ�...?
      echo ��������java.exe�ⶫ��
      echo ��ΰ��㲹�Ϲ�~
      set "_Java='%_Java%\java.exe'"
      goto Server_Action_Center
   )
   set "_Java=java"
   echo ���ϴ�!��û��java.exe��
   echo �Ѿ��л�ΪĬ��java.
   goto Server_Action_Center

:set_RAMmin
   echo �������������ʼ�ڴ�ռ��(��λ:MB,1GB=1024MB), Ĭ��ֵ:0
   set /p "_RAMmin="
   goto Check_RAM

:set_RAMmax
   echo ���������������ڴ�ռ��(��λ:MB,1GB=1024MB), Ĭ��ֵ:4096
   set /p "_RAMmax="
   goto Check_RAM

:Choose & :: ������ʽѡ��
   set %ERRORLEVEL%=0
   echo ��ѡ�񿪷���ʽ:
   echo   [1]�Զ�����5��
   echo   [2]�Զ�����10��
   echo   [I]�����Զ�����
   echo   [3]���Է�����(����1��)
   echo   [4]���Է�����(������)
   echo   [0]���ط�������������
   echo ����ѡ��Ĳ˵���:
   choice /C:12I034 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 (
      set _chk_mod=5
      goto Start_Server
   )
   if %_erl%==2 (
      set _chk_mod=10 
      goto Start_Server
   ) 
   if %_erl%==3 (
      set _chk_mod=infinity 
      goto Confirm
   )
   if %_erl%==4 goto Server_Action_Center
   if %_erl%==5 (
      set _chk_mod=1
      goto Start_Server
   )
   if %_erl%==6 (
     set _chk_mod=0
     goto Start_Server
   )

:Confirm & :: ȷ��ѡ��[infinity]
   cls
   set %ERRORLEVEL%=0
   echo ��ȷ��ѡ������ģʽ��?
   echo ����ģʽֻ���� Ctrl+C �� �رմ���(���Ƽ�) ���رշ�����
   echo ����Yȷ��, ����N�ص�ѡ�����
   choice /C:YN /N
   set _erl=%ERRORLEVEL%
   if %_erl%==2 goto Choose
   if %_erl%==1 goto Start_Server

:Modify_MODs_PLGs
   if %_mod%==nul (
      echo �ƺ�...����Minecraftԭ�����!
      echo ԭ����Ĳ��ɼ��ز��/ģ��
      echo �����˻�...
      goto Server_Action_Center
   )
   echo ��ѡ����Ŀ:
   echo   [1]MOD
   echo   [2]PLUGIN
   echo   [3]���ط�������������
   echo ����ѡ��Ĳ˵���:
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Modify_MODs
   if %_erl%==2 goto Modify_PLUGINs
   if %_erl%==3 goto Server_Action_Center
   :Modify_MODs
      if not exist ".\mods" (
        echo [ERROR]:û��mods�ļ��� 
        echo [INFO]:������...
        md .\mods
        echo [INFO]:�������!
      ) 
      cd ".\mods"
      dir
      goto un_ban
   :Modify_PLUGINs
      if not exist ".\plugins" ( 
         echo [ERROR]:û��plugins�ļ��� 
         echo [INFO]:������:
         md .\plugins
         echo [INfO]:�������!
      )
      cd ".\plugins"
      dir
   :un_ban
      echo ������ģ��/�������:
   echo С��ʾ: ����������ѡ���������Ҽ����μ�����ɸ��ƺ�ճ��
   echo ע��: ��Ҫ���ƺ�׺!
   set /p "_mods_plgs="
   if not exist ".\%_mods_plgs%" ( 
      if exist ".\%_mods_plgs%.jar" ( 
         set mods_plgs=%_mods_plgs%.jar 
      ) else ( 
         if exist ".\%_mods_plgs%.ban" ( 
            ren ".\%_mods_plgs%.ban" %_mods_plgs% 
            echo ģ��/��� %_mods_plgs% ������
            cd .. 
            goto Server_Action_Center
         ) else ( 
           if exist ".\%_mods_plgs%.disabled" (
              ren ".\%_mods_plgs%.disabled" %_mods_plgs%
              echo ģ��/��� %_mods_plgs% ������
              cd ..
              goto Server_Action_Center
           )
           echo [ERROR]:������һ����������
           echo [ERROR]:�ڽ����ı�%_mods_plgs%����! 
           pause >nul 
           exit /b 
         ) 
      ) 
   )
   echo ��ѡ�����:
   echo [1]����ģ��
   echo [2]����ģ��
   echo ֱ���������
   choice /C:12 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 ( 
     ren ".\%_mods_plgs%" %_mods_plgs%.ban 
     echo ģ��/��� %_mods_plgs% �ѽ��� 
   )
   if %_erl%==2 ( 
     if exist ".\%_mods_plgs%.ban" (
         ren ".\%_mods_plgs%.ban" %_mods_plgs% 
     )
     if exist ".\%_mods_plgs%.disabled" (
         ren ".\%_mods_plgs%.disabled" %_mods_plgs% 
     )
     echo ģ��/��� %_mods_plgs% ������ 
   )
   cd ..
   goto Server_Action_Center

:setServer & :: ���ú���(���δ��⵽)
   echo �������������:
   set /p "_Server="
::   if not exist ".\*.jar" (
::      echo û�к��ģ�
::      echo �Ͻ�ȥ����һ��
::      echo ��Ҫ��ʲô��������
::      echo     [1] vanilla ԭ�������
::      echo     [2] Fabric �Ƽ��߰汾
::      echo     [3] Forge �Ƽ��Ͱ汾
::      echo     [4] Carpet 
::      echo     [5] MCDR qb������(���� MCDR ֻ�Ƿ������Ŀ��ӣ����滹Ҫװ������...
::      echo     [6] Bukkit
::      echo     [7] Paper
::      echo     [8] Purpur
::      echo     [9] Arclight
::      echo     [0] �������
::      choice /C:1234567890 /N
::      pause >nul
::   )
   if exist ".\%_Server%" (
      echo ��⵽����:%_Server% 
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   ) 
   if exist ".\%_Server%.jar" (
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo ��⵽����:%_Server% 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.ban" (
      ren ".\%_Server%.ban" %_Server% 
      echo ���������� %_Server% �����ò�ѡ�� 
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   )
   if exist ".\%_Server%.disabled" (
      ren ".\%_Server%.disabled" %_Server% 
      set "_ACS=unAutoCheckingServer"
      echo ���������� %_Server% �����ò�ѡ�� 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.jar.ban" (
      ren ".\%_Server%.jar.ban" %_Server%.jar 
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo ���������� %_Server% �����ò�ѡ�� 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.jar.disabled" (
      ren ".\%_Server%.jar.disabled" %_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      set _Server=%_Server%.jar 
      echo ���������� %_Server% �����ò�ѡ�� 
      goto Server_Action_Center
   )
   echo [ERROR]:����%_Server%������!
   if %_Chk_Server%==true (
      echo ��ѡ�����:
      echo  [1]�Զ����
      echo  [2]�ֶ�����
      echo  [3]����, ѡ��Ĭ�� Start.jar ����
      choice /C:123 /N
      set _erl=%ERRORLEVEL%
      if %_erl%==3 (
         echo ����ִ�в���...
         set "Server=Start.jar"
         goto Server_Action_Center
      )
      if %_erl%==2 goto AutoCheckingServer
      if %_erl%==1 goto setServer
   )
   set "_Server=Start.jar"
   echo ��ѡ��Ĭ�Ϻ���:Start.jar
   set "_ACS=unAutoCheckingServer"
   goto Server_Action_Center
 
:Check_RAM
   if %_RAMmax%==0 (
     echo emmm...���Ϊ0M...
     echo ��������ô��?
     echo Ӧ���ǳ�ʼΪ0M��...
     if %_RAMmin%==0 (
        echo ��ʼҲ��0M?
        echo �ȸ�����������
        set "_RAMmax=4096"
        goto Server_Action_Center
     )
     echo �Ҹ��㻻�˹�
     set "_RAMmax=%_RAMmin%"
     set _RAMmin=0
     goto Server_Action_Center
   )
   set /a "_temp=%_RAMmax%-%_RAMmin%"
   if %_temp% GEQ 0 (
      echo ���óɹ�! 
      goto Server_Action_Center
   )
   echo [ERROR]:�������ڴ��ʼֵ�������ֵ ( max:%_RAMmax% min:%_RAMmin% )
   echo ��ѡ�����:
   echo   [1]����ֵ
   echo   [2]�������ֵ
   echo   [3]���ĳ�ʼֵ
   choice /C:123 /N
   if %ERRORLEVEL%==1 set _RAMmax=4096 & set _RAMmin=0 & goto Server_Action_Center
   if %ERRORLEVEL%==2 goto set_RAMmax
   if %ERRORLEVEL%==3 goto set_RAMmin
   if %ERRORLEVEL%==0 goto Server_Action_Center

:AutoCheckingServer & :: ������
   echo �Զ���������......
   if exist ".\fabric-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=fabric-server-launch.jar"
      set "_mod=true"
      echo ��⵽����:fabric-server-launch.jar
      goto Server_Action_Center
   )
   if exist ".\quilt-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=quilt-server-launch.jar" 
      set "_mod=true"
      echo ��⵽����:quilt-server-launch.jar 
      goto Server_Action_Center
   )
   if exist ".\BungeeCord.jar" (
      set _Chk_Server=true
     set "_Server=BungeeCord.jar"
     set _mod=true
     set _RAMmax=512
     echo ��,��Ȼ����������ű���BungeeCord
     echo �ȿ��ڴ�ռ�ã�
     goto Server_Action_Center
   )
   if exist ".\Server.jar" (
      set _Chk_Server=true
      set "_Server=Server.jar" 
      set "_mod=false"
      echo ��⵽����:Server.jar 
      goto Server_Action_Center
   )
   if exist ".\minecraft_server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft_server.jar"
      set "_mod=false" 
      echo ��⵽����:minecraft_server.jar 
      goto Server_Action_Center
   )
   if exist ".\minecraft-server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft-server.jar"
      set "_mod=false"
      echo ��⵽����:minecraft-server.jar
      goto Server_Action_Center
   )
   echo δ��⵽����������! 
   goto setServer

::============================================================================================================================

:Config

   echo ��ѡ�����:
   echo [1]��������
   echo [2]��ȡ����
   echo [0]��������������
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Save_Config
   if %_erl%==2 goto Read_Config
   if %_erl%==3 (
      if %User%==Admin goto Admin_Action_Center
      goto Main_Action_Center
   )
   
   :Save_Config
      echo @rem ���ǿ����ű��������ļ� > config.bat
      echo @rem ÿ�α��涼�Ḳ�ǵ��������ַ� >> config.bat
      echo @rem ��Ҫ�Ҹ�Ŷ���ر��� �� = �� ǰ��ģ� >>config.bat
      echo @rem Ҫ��Ҳֻ�ܸ�ÿ�� ��=�� ����� >>config.bat
      echo. >>config.bat
      echo set _Server=%_Server% >> config.bat
      echo set _RAMmax=%_RAMmax% >> config.bat
      echo set _RAMmin=%_RAMmin% >> config.bat
      echo set _Java=%_Java% >> config.bat
      echo set _EULA=%_eula% >> config.bat
      echo set _Frpc=%_Frpc% >> config.bat
      echo set _Frpc_Config=%_Frpc_Config% >> config.bat
      echo. >>config.bat
   
   :Read_Config
      if not exist config.bat (
         echo �޷�ʶ�������ļ���
         echo �밴���������...
         pause >nul
         goto Config
      )
      call config.bat

::============================================================================================================================

:Start_Frp
   echo frp������...
   start %_Frpc% -c %_Frpc_Config%
   goto Frp_Action_Center

::============================================================================================================================

:Start_Server
   title ������������ [��������:%_error%��] ����رմ���!!!
   echo =========================================
   echo               ���������ڿ���
   echo           The server is starting!
   echo =========================================
   powershell /C %_Java% -jar -Dfile.encoding=GBK -Xms%_RAMmin%M -Xmx%_RAMmax%M %_Server% nogui
   ::if %_eula%==false goto First_Start
   set /a _restart+=1
   set /a _error+=1
   if %_chk_mod%==infinity goto Start_Server
   if %_chk_mod%==1 goto restart_1
   if %_chk_mod%==5 goto restart_5
   if %_chk_mod%==10 goto restart_10
   if %_chk_mod%==0 goto Crash

   :restart_1
      if %_restart%==1 goto Crash
      goto Start_Server
   :restart_5
      if %_restart%==6 goto Crash 
      goto Start_Server
   :restart_10
      if %_restart%==11 goto Crash
      goto Start_Server

   :First_Start & :: �����޸�
      echo Minecraft EULA Э��δͬ��!
      echo ��ͬ��Э��, Э���ļ��ڷ�������Ŀ¼�µ�EULA.txt
      echo ͬ��Э�鷽��: ��eula.txt, ���� eula=false Ϊ eula=true ������
      echo ͬ��Э����밴���������...
      pause >nul
      if exist ".\EULA.TXT" set eula=true
      goto Start_Server

:Crash & :: ����
   set _restart=0
   title �������ѱ��� :(
   echo =========================================
   echo             �������ܼƱ���%_error%��
   echo          ��������־�ļ���.\logs\��
   echo        ����������.\crash-report\��
   echo =========================================
   echo ��C���رսű�
   echo ��R������������
   echo ��B������ѡ�񿪷�ģʽ
   echo ��P�����������ű�
   choice /C:CRBP /N
   set _erl=%ERRORLEVEL%
   if %_erl%==4 (
     cls 
     set "_ACS=unAutoCheckingServer" 
     goto Initialize
   )
   if %_erl%==3 goto Choose
   if %_erl%==2 goto Check
   if %_erl%==1 exit /b
