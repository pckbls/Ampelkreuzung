unit TrafficSignal;

{$mode delphi}

interface

uses
	SysUtils, Graphics, Classes, LCLIntf,
	Entity;

type
	TSignalSequence = (Go, Stop);
	
	TSignalEntity = class(TEntity)
		protected
			CurrentSequence: TSignalSequence;
			procedure SetSequence(s: TSignalSequence); virtual;
	
		public
			ID: String;
		
			property Sequence: TSignalSequence read CurrentSequence write SetSequence;
	end;

	TPedestrianSignalEntity = class(TSignalEntity)	
		public
			constructor Create;
			procedure Paint; override;
	end;
	
	TCarSignalEntity = class(TSignalEntity)
		protected
			NextSequence: TSignalSequence;
			LastChange: LongInt;
			
			procedure SetSequence(s: TSignalSequence); override;
	
		public			
			constructor Create;
			
			procedure Paint; override;
			function Think: Boolean; override;
	end;

implementation

procedure TSignalEntity.SetSequence;
begin
	self.CurrentSequence := s;
end;

constructor TPedestrianSignalEntity.Create;
begin
	inherited;
	
	self.CurrentSequence := Stop;
end;

procedure TPedestrianSignalEntity.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Pen.Width := 1;
		Pen.Style := psSolid;
		Pen.Color := clBlack;
	
		Brush.Color := clGray;
		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
		
		if self.Sequence = Stop then
			Brush.Color := clRed
		else
			Brush.Color := clGray;
		self.DrawEllipse(-0.675, -0.8, 0.675, -0.15);
		
		
		if self.Sequence = Go then
			Brush.Color := clGreen
		else
			Brush.Color := clGray;
		self.DrawEllipse(-0.675, 0.15, 0.675, 0.8);
	end;
end;

constructor TCarSignalEntity.Create;
begin
	inherited;
	
	self.CurrentSequence := Stop;
	self.NextSequence := Stop;
end;

procedure TCarSignalEntity.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Pen.Width := 1;
		Pen.Style := psSolid;
		Pen.Color := clBlack;
	
		Brush.Color := clGray;
		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
		
		if self.CurrentSequence = Stop then
			Brush.Color := clRed
		else
			Brush.Color := clGray;
		self.DrawEllipse(-0.4, -0.8, 0.4, -0.4);
		
		if self.CurrentSequence <> self.NextSequence then
			Brush.Color := clYellow
		else
			Brush.Color := clGray;
		self.DrawEllipse(-0.4, -0.2, 0.4, 0.2);
		
		
		if (self.CurrentSequence = Go) and (self.NextSequence <> Stop) then
			Brush.Color := clGreen
		else
			Brush.Color := clGray;
		self.DrawEllipse(-0.4, 0.4, 0.4, 0.8);
	end;
end;

procedure TCarSignalEntity.SetSequence;
begin
	if s = self.CurrentSequence then
		exit;

	self.LastChange := GetTickCount;
	self.NextSequence := s;
end;

function TCarSignalEntity.Think;
var
	Now: LongInt;
begin
	Result := True;

	if self.CurrentSequence = self.NextSequence then
		exit;

	Now := GetTickCount;
	if Now - self.LastChange > 1000 then
	begin
		self.CurrentSequence := self.NextSequence;
		self.LastChange := Now;
	end;
end;

end.
