; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "���� �������"
#define MyAppVersion "1.1"
#define MyAppPublisher "Shaginyan Sergey"
#define MyAppExeName "ShipSchedule.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F1C3E6A1-F1C6-411E-961A-40B9FEC3F7F1}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\Shipment s�hedule 
DefaultGroupName={#MyAppName}
OutputDir=C:\Users\������� ������\������� ���������\Borland Studio Projects\������� ����������\������ ��������\Install
OutputBaseFilename=update
SetupIconFile=C:\Users\������� ������\������� ���������\Borland Studio Projects\������� ����������\������ ��������\Install\world.ico
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Files]
Source: "C:\Users\������� ������\������� ���������\Borland Studio Projects\������� ����������\������ ��������\Project1.exe"; DestDir: "{app}"; DestName: "ShipSchedule.exe"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files