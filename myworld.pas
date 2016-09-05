unit MyWorld;

{$mode delphi}

interface

uses
	SysUtils, Graphics,
	World, Entity, Car, TrafficSignal, SignalSystem, SpawnSystem, Destroyer, StopLine, Rotator;

type
	TMyWorld = class(TWorld)
		public
			constructor Create;
			procedure Paint; override;
	end;

	{TMyTrafficSignal = class(blabla)
	end;}

implementation

constructor TMyWorld.Create;
var
	e, s: TEntity;
	ss: TSignalSystemEntity;
begin
	inherited;
	
	ss := TSignalSystemEntity.Create;
	self.EntList.Add(ss);

	s := TCarSignalEntity.Create;
	s.x := 0.3; s.y := 0.8; s.width := 0.04; s.height := 0.1;
	(s as TSignalEntity).ID := 'einbahn1';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	e := TStopLineEntity.Create;
	e.x := 0.42; e.y := 0.755; e.width := 0.01; e.height := 0.14;
	e.orientation := right;
	(e as TStopLineEntity).Signal := s as TSignalEntity;
	self.EntList.Add(e);

	s := TCarSignalEntity.Create;
	s.x := 0.7; s.y := 0.8; s.width := 0.04; s.height := 0.1;
	s.orientation := up;
	(s as TSignalEntity).ID := 'einbahn2';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	e := TStopLineEntity.Create;
	e.x := 0.58; e.y := 0.755; e.width := 0.01; e.height := 0.14;
	e.orientation := right;
	(e as TStopLineEntity).Signal := s as TSignalEntity;
	self.EntList.Add(e);

	s := TCarSignalEntity.Create;
	s.x := 0.2; s.y := 0.65; s.width := 0.04; s.height := 0.1;
	s.orientation := right;
	(s as TSignalEntity).ID := 'haupt1';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	e := TStopLineEntity.Create;
	e.x := 0.29; e.y := 0.5; e.width := 0.01; e.height := 0.14;
	e.orientation := up;
	(e as TStopLineEntity).Signal := s as TSignalEntity;
	self.EntList.Add(e);

	s := TCarSignalEntity.Create;
	s.x := 0.89; s.y := 0.15; s.width := 0.04; s.height := 0.1;
	s.orientation := left;
	(s as TSignalEntity).ID := 'haupt2';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);
	
	e := TStopLineEntity.Create;
	e.x := 0.82; e.y := 0.3; e.width := 0.01; e.height := 0.14;
	e.orientation := up;
	(e as TStopLineEntity).Signal := s as TSignalEntity;
	self.EntList.Add(e);

	s := TPedestrianSignalEntity.Create;
	s.x := 0.7; s.y := 0.7; s.width := 0.02; s.height := 0.05;
	s.orientation := left;
	(s as TSignalEntity).ID := 'fuss1';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	s := TPedestrianSignalEntity.Create;
	s.x := 0.3; s.y := 0.63; s.width := 0.02; s.height := 0.05;
	s.orientation := right;
	(s as TSignalEntity).ID := 'fuss2';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	s := TPedestrianSignalEntity.Create;
	s.x := 0.76; s.y := 0.65; s.width := 0.02; s.height := 0.05;
	s.orientation := up;
	(s as TSignalEntity).ID := 'fuss3';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	s := TPedestrianSignalEntity.Create;
	s.x := 0.69; s.y := 0.16; s.width := 0.02; s.height := 0.05;
	s.orientation := down;
	(s as TSignalEntity).ID := 'fuss4';
	ss.AddSignal(s as TSignalEntity);
	self.EntList.Add(s);

	e := TRotateEntity.Create;
	e.x := 0.45; e.y := 0.23; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	self.EntList.Add(e);

	e := TRotateEntity.Create;
	e.x := 0.6; e.y := 0.43; e.width := 0.05; e.height := 0.1;
	e.orientation := right;
	self.EntList.Add(e);

	e := TSpawnEntity.Create;
	e.x := 1.6; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	e := TSpawnEntity.Create;
	e.x := -1.6; e.y := 0.5; e.width := 0.05; e.height := 0.1;
	e.orientation := right;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	e := TSpawnEntity.Create;
	e.x := 0.425; e.y := 1.6; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	e := TSpawnEntity.Create;
	e.x := 0.575; e.y := 1.6; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	e := TDestroyEntity.Create;
	e.x := -0.2; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	e := TDestroyEntity.Create;
	e.x := 1.2; e.y := 0.5; e.width := 0.05; e.height := 0.1;
	e.orientation := right;
	e.LinkEntList(self.EntList);
	self.EntList.Add(e);

	exit;
	
	e := TCarEntity.Create;
	e.x := 0.95; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clGreen;
	(e as TCarEntity).MaxSpeed := 0.15;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 1.08; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clWhite;
	(e as TCarEntity).MaxSpeed := 0.1;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 2.7; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clRed;
	(e as TCarEntity).MaxSpeed := 0.22;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 2.9; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clPurple;
	(e as TCarEntity).MaxSpeed := 0.2;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 3.8; e.y := 0.3; e.width := 0.05; e.height := 0.1;
	e.orientation := left;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clPurple;
	(e as TCarEntity).MaxSpeed := 0.15;
	self.EntList.Add(e);
	
	e := TCarEntity.Create;
	e.x := 0.2; e.y := 0.5; e.width := 0.05; e.height := 0.1;
	e.orientation := right;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clYellow;
	(e as TCarEntity).MaxSpeed := 0.12;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 0.05; e.y := 0.5; e.width := 0.05; e.height := 0.1;
	e.orientation := right;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clBlack;
	(e as TCarEntity).MaxSpeed := 0.09;
	self.EntList.Add(e);
	
	e := TCarEntity.Create;
	e.x := 0.575; e.y := 0.85; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clRed;
	(e as TCarEntity).MaxSpeed := 0.2;
	self.EntList.Add(e);
	
	e := TCarEntity.Create;
	e.x := 0.575; e.y := 0.98; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clWhite;
	(e as TCarEntity).MaxSpeed := 0.1;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 0.425; e.y := 0.85; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clPurple;
	(e as TCarEntity).MaxSpeed := 0.15;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 0.425; e.y := 0.98; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clBlue;
	(e as TCarEntity).MaxSpeed := 0.1;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 0.425; e.y := 1.2; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clBlack;
	(e as TCarEntity).MaxSpeed := 0.1;
	self.EntList.Add(e);

	e := TCarEntity.Create;
	e.x := 0.425; e.y := 2.5; e.width := 0.05; e.height := 0.1;
	e.orientation := up;
	e.LinkEntList(self.EntList);
	(e as TCarEntity).Color := clGreen;
	(e as TCarEntity).MaxSpeed := 0.15;
	self.EntList.Add(e);
end;

procedure TMyWorld.Paint;
begin
	inherited;
	
	with self.PaintBox.Canvas do
	begin
		Brush.Color := clGray;
		
		FillRect(0, Round(0.2 * self.PaintBox.Height),
		         self.PaintBox.Width, Round(0.6 * self.PaintBox.Height));
		FillRect(Round(0.34 * self.PaintBox.Width), Round(0.6 * self.PaintBox.Height),
		         Round(0.66 * self.PaintBox.Width), self.PaintBox.Height);
		         
		Pen.Color := clWhite;
		Pen.Style := psDash;
		Pen.Width := 3;
		
		MoveTo(0, Round(0.4 * self.PaintBox.Height));
		LineTo(self.PaintBox.Width, Round(0.4 * self.PaintBox.Height));

		MoveTo(Round(0.5 * self.PaintBox.Width), Round(0.75 * self.PaintBox.Height));
		LineTo(Round(0.5 * self.PaintBox.Width), self.PaintBox.Height);

		{ zeichne fußgänger-überwege }
		Pen.Style := psDash;
		Pen.Width := 2;

		MoveTo(Round(0.69 * self.PaintBox.Width), Round(0.2 * self.PaintBox.Height));
		LineTo(Round(0.69 * self.PaintBox.Width), Round(0.6 * self.PaintBox.Height));
		MoveTo(Round(0.76 * self.PaintBox.Width), Round(0.2 * self.PaintBox.Height));
		LineTo(Round(0.76 * self.PaintBox.Width), Round(0.6 * self.PaintBox.Height));

		MoveTo(Round(0.34 * self.PaintBox.Width), Round(0.63 * self.PaintBox.Height));
		LineTo(Round(0.66 * self.PaintBox.Width), Round(0.63 * self.PaintBox.Height));
		MoveTo(Round(0.34 * self.PaintBox.Width), Round(0.7 * self.PaintBox.Height));
		LineTo(Round(0.66 * self.PaintBox.Width), Round(0.7 * self.PaintBox.Height));

		{ Zeichne Haltelinien }
		Pen.Style := psSolid;
		Pen.Width := 3;

		MoveTo(Round(0.3 * self.PaintBox.Width), Round(0.4 * self.PaintBox.Height));
		LineTo(Round(0.3 * self.PaintBox.Width), Round(0.6 * self.PaintBox.Height));
		MoveTo(Round(0.81 * self.PaintBox.Width), Round(0.2 * self.PaintBox.Height));
		LineTo(Round(0.81 * self.PaintBox.Width), Round(0.4 * self.PaintBox.Height));

		MoveTo(Round(0.34 * self.PaintBox.Width), Round(0.75 * self.PaintBox.Height));
		LineTo(Round(0.66 * self.PaintBox.Width), Round(0.75 * self.PaintBox.Height));
	end;
end;

end.
