unit SpawnSystem;

{$mode delphi}

interface

uses
	SysUtils, ExtCtrls, Graphics, Classes, LCLIntf,
	Entity, Car;

type
	TSpawnEntity = class(TEntity)
		protected
			LastSpawn: LongInt;
			
			function CanSpawn: Boolean;
	
		public
			constructor Create;
		
			procedure Paint; override;
			function Think: Boolean; override;
	end;

const
	CarColors: array[0..13] of TColor = (clAqua, clDkGray, clLime, clFuchsia,
	                                     clNavy, clOlive, clSilver, clTeal, clRed,
	                                     clGreen, clYellow, clWhite, clBlack, clPurple);

implementation

constructor TSpawnEntity.Create;
begin
	self.LastSpawn := GetTickCount;
end;

procedure TSpawnEntity.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Pen.Width := 1;
		Pen.Style := psSolid;
		Pen.Color := clGreen;
	
		Brush.Color := clGreen;
 		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
	end;
end;

function TSpawnEntity.CanSpawn;
var
	myself, i: Integer;
	e: TEntity;
begin
	Result := True;
	
	myself := self.EntList.IndexOf(self);

	for i := 0 to self.EntList.Count - 1 do
	begin
		if i = myself then
			continue;
		
		e := self.EntList.Items[i] as TEntity;
		if not (e is TCarEntity) then
			continue;
		
		if (self.TopLeft.X < e.BottomRight.X)
		and (self.BottomRight.X > e.TopLeft.X)
		and (self.TopLeft.Y < e.BottomRight.Y)
		and (self.BottomRight.Y > e.TopLeft.Y) then
		begin
			Result := false;
			break;
		end;
	end;
end;

function TSpawnEntity.Think;
var
	Now: LongInt;
	c: TCarEntity;
begin
	Result := True;

	Now := GetTickCount;
	if (self.CanSpawn) and (Now - self.LastSpawn > 3000) then
	begin
		c := TCarEntity.Create;
		c.LinkPaintBox(self.PaintBox);
		c.x := self.X; c.y := self.Y; c.width := 0.05; c.height := 0.1;
		c.orientation := self.Orientation;
		c.LinkEntList(self.EntList);
		
		c.Color := CarColors[Random(14)];
		
		c.MaxSpeed := (Random(15) + 8) / 100;
		self.EntList.Add(c);
		
		self.LastSpawn := Now;
	end;
end;

end.
