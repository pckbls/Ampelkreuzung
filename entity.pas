unit Entity;

{$mode delphi}

interface

uses
	Types, SysUtils, Graphics, ExtCtrls, Contnrs;

type
	TOrientation = (up, down, left, right);

	TRealPoint = record
		X, Y: Real;
	end;

	TEntity = class
		protected
			PaintBox: TPaintBox;
			EntList: TFPObjectList;

			procedure DrawLine(x1, y1, x2, y2: Real);
			procedure DrawRectangle(x1, y1, x2, y2: Real);
			procedure DrawFillRect(x1, y1, x2, y2: Real);
			procedure DrawEllipse(x1, y1, x2, y2: Real);

            function RotatePoint(x, y: Real): TRealPoint;
			function TransformPoint(x, y: Real): TPoint;

			function GetTopLeft: TRealPoint;
			function GetBottomRight: TRealPoint;

		public
			Orientation: TOrientation;
			X, Y, Width, Height: Real;
			MaxSpeed, Speed: Real;
			Delete: Boolean;

			constructor Create;
			
			procedure LinkEntList(var l: TFPObjectList);
			
			procedure Paint; virtual;
			procedure LinkPaintBox(var PaintBox: TPaintBox);
			
			function Think: Boolean; virtual;
			procedure Touch(e: TEntity); virtual;
			procedure Click; virtual;

			property TopLeft: TRealPoint read GetTopLeft;
			property BottomRight: TRealPoint read GetBottomRight;
	end;

implementation

constructor TEntity.Create;
begin
	self.x := 0; self.y := 0;
	self.width := 0; self.height := 0;
	self.MaxSpeed := 0; self.Speed := 0;
	self.orientation := up;
	self.Delete := false;
end;

procedure TEntity.LinkEntList;
begin
	self.EntList := l;
end;

procedure TEntity.LinkPaintBox;
begin
	self.PaintBox := PaintBox;
end;

function TEntity.GetTopLeft;
begin
	if self.orientation in [up, down] then
	begin
		Result.x := self.x - 1/2 * self.width;
		Result.y := self.y - 1/2 * self.height;
	end
	else
	begin
		Result.x := self.x - 1/2 * self.height;
		Result.y := self.y - 1/2 * self.width;
	end;
end;

function TEntity.GetBottomRight;
begin
	if self.orientation in [up, down] then
	begin
		Result.x := self.x + 1/2 * self.width;
		Result.y := self.y + 1/2 * self.height;
	end
	else
	begin
		Result.x := self.x + 1/2 * self.height;
		Result.y := self.y + 1/2 * self.width;
	end;
end;

function TEntity.RotatePoint;
var
	phi, xn, yn: Real;
begin
	case self.orientation of
		up:    phi := 0;
		left:  phi := 3/2 * Pi;
		down:  phi := Pi;
		right: phi := 1/2 * Pi;
	end;
	
	xn := x * cos(phi) - y * sin(phi);
	yn := x * sin(phi) + y * cos(phi);
	
	if self.orientation in [up, down] then
	begin
		xn := self.x + 1/2 * xn * self.width;
		yn := self.y + 1/2 * yn * self.height;
	end
	else
	begin
		xn := self.x + 1/2 * xn * self.height;
		yn := self.y + 1/2 * yn * self.width;
	end;
	
	Result.X := xn;
	Result.Y := yn;
end;

function TEntity.TransformPoint;
var
	p: TRealPoint;
begin
    p := self.RotatePoint(X, Y);

	Result := Point(Round(p.X * self.PaintBox.Width),
	                Round(p.Y * self.PaintBox.Height));
end;

procedure TEntity.DrawLine;
var	
	p1, p2: TPoint;
begin
	p1 := self.TransformPoint(x1, y1);
	p2 := self.TransformPoint(x2, y2);

	with self.PaintBox.Canvas do
	begin
		MoveTo(p1);
		LineTo(p2);
	end;
end;

procedure TEntity.DrawRectangle;
var
	p1, p2: TPoint;
begin
	p1 := self.TransformPoint(x1, y1);
	p2 := self.TransformPoint(x2, y2);
	
	self.PaintBox.Canvas.Rectangle(p1.x, p1.y, p2.x, p2.y);
end;

procedure TEntity.DrawFillRect;
var
	p1, p2: TPoint;
begin
	p1 := self.TransformPoint(x1, y1);
	p2 := self.TransformPoint(x2, y2);

	self.PaintBox.Canvas.FillRect(p1.x, p1.y, p2.x, p2.y);
end;

procedure TEntity.DrawEllipse;
var
	p1, p2: TPoint;
begin
	p1 := self.TransformPoint(x1, y1);
	p2 := self.TransformPoint(x2, y2);

	self.PaintBox.Canvas.Ellipse(p1.x, p1.y, p2.x, p2.y);
end;

function TEntity.Think;
begin
	Result := true;
end;

procedure TEntity.Paint;
begin
	{ nothing }
end;

procedure TEntity.Touch;
begin
	{ nothing }
end;

procedure TEntity.Click;
begin
	{ nothing }
end;

end.
