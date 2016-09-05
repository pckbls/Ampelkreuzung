program Ampelsystem;

{$mode delphi}

uses
	cthreads, sysutils, interfaces, forms,
	world, entity, mainform;

begin
	Application.Initialize;
	Application.CreateForm(TMainForm, FMain);
	Application.Run;
end.
