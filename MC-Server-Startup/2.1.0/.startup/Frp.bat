:: ����
@echo off

:: �ű��༭ע������:
:: ��βע��Ҫ������ '&' ������Ϊע��
:: ��������ģ��ǵ�Ҫ�ո�

set _version=2.1.0 & :: �汾��

:: ���� Frp �Ŀ����ű�
:: �⽫��Խ��� main.bat

:Frp_Action_Center

   cls
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
   if %_erl%==1 call 2.1.0-main.bat
   if %_erl%==2 goto :Start_Frp
   if %_erl%==3 goto :Save_Frp

:Start_Frp

:Save_Frp
