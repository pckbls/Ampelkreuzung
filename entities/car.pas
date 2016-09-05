unit Car;

{$mode delphi}

interface

uses
	SysUtils, Graphics, Classes, LCLIntf,
	Entity, StopLine, TrafficSignal, Rotator;

type
	TCarEntity = class(TEntity)
		protected
			Rotated, AtStopLine, Hurry: Boolean;
			Signal: TSignalEntity;
			
		public
			Color: TColor;

			procedure Paint; override;
			procedure Touch(e: TEntity); override;
			function Think: Boolean; override;
	end;

implementation

procedure TCarEntity.Paint;
begin
	Randomize;

	with self.PaintBox.Canvas do
	begin
		Pen.Style := psSolid;	

		{ draw tires }
		Pen.Color := clBlack;
		Pen.Width := Round(self.Width * Width / 5);
		self.DrawLine(-1.0, -0.7, -1.0, -0.5);
		self.DrawLine(1.0, -0.7, 1.0, -0.5);
		self.DrawLine(-1.0, 0.5, -1.0, 0.7);
		self.DrawLine(1.0, 0.5, 1.0, 0.7);
		
		{ draw headlights }
		Pen.Color := clYellow;
		self.DrawLine(-0.8, -1.05, -0.6, -1.05);
		self.DrawLine(0.6, -1.05, 0.8, -1.05);
	
		{ draw body }
		Pen.Width := 1;
		Pen.Color := clBlack;
		Brush.Color := self.Color;
		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
		
		{ draw bonnet }
		self.DrawLine(-1.0, -1.0, -0.8, -0.7);
		self.DrawLine(1.0, -1.0, 0.8, -0.7);
		
		{ draw trunk }
		self.DrawLine(-0.8, 0.7, -1.0, 1.0);
		self.DrawLine(0.8, 0.7, 1.0, 1.0);
		
		{ draw roof }
		self.DrawLine(-0.8, -0.3, -0.8, 0.3);
		self.DrawLine(0.8, -0.3, 0.8, 0.3);
		
		{ draw windshield }
		Brush.Color := clBlue;
		self.DrawRectangle(-0.8, -0.7, 0.8, -0.3);
		
		{ draw back window }
		self.DrawRectangle(-0.8, 0.3, 0.8, 0.7);
	end;
end;

function TCarEntity.Think;
var
	i: Integer;
	c: TCarEntity;
	X, Y, Distance: Real;
begin
	self.Speed := self.MaxSpeed;
	
	for i := 0 to self.EntList.Count - 1 do
	begin
		if not (self.EntList.Items[i] is TCarEntity) then
			continue;
		
		c := self.EntList.Items[i] as TCarEntity;
		
		X := self.X; Y := self.Y;	
		case self.Orientation of
			up:
			begin
				Y := self.TopLeft.Y - 0.07;
				Distance := self.TopLeft.Y - c.BottomRight.Y;
			end;
			
			down:
			begin
				Y := self.BottomRight.Y + 0.07;
				Distance := c.TopLeft.Y - self.BottomRight.Y;
			end;
			
			left:
			begin
				X := self.TopLeft.X - 0.07;
				Distance := self.TopLeft.X - c.BottomRight.X;
			end;
			
			right:
			begin
				X := self.BottomRight.X + 0.07;
				Distance := c.TopLeft.X - self.BottomRight.X;
			end;
		end;
		
		if  (X > c.TopLeft.X) and (X < c.BottomRight.X)
		and (Y > c.TopLeft.Y) and (Y < c.BottomRight.Y) then
		begin
			if (distance > 0.06) then
				self.Speed := c.Speed
			else
				self.Speed := 0;
		end;
	end;

	if self.AtStopLine then
	begin
		if not self.Hurry then
		begin
			if self.Signal.Sequence = Stop then
				self.Speed := 0
			else
				self.Hurry := true;
		end;
	
		self.AtStopLine := false;
	end
	else
		self.Hurry := false;
	
	Result := true;
end;

procedure TCarEntity.Touch;
begin
	if (not self.Rotated) and (e is TRotateEntity) then
	begin
		self.Rotated := true;
		self.Orientation := e.Orientation;
	end;
	
	if (not self.AtStopLine) and (e is TStopLineEntity) then
	begin
		self.AtStopLine := true;
		self.Signal := (e as TStopLineEntity).Signal as TSignalEntity;
	end;
end;

end.
