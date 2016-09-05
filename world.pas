unit World;

{$mode delphi}

interface

uses
	SysUtils, Graphics, ExtCtrls, Classes, Contnrs, LCLIntf,
	Entity, Car;

type
	TWorld = class(TThread)
		protected
			PaintBox: TPaintBox;
	
		public
			EntList: TFPObjectList;

			constructor Create;
			
			procedure Execute; override;
			
			procedure LinkPaintBox(PaintBox: TPaintBox);
			function TransformWorldPoint(x, y: real): TPoint;
			procedure Paint; virtual;
			procedure PaintEntities;
			procedure Click(X, Y: Real);

			{ Property Entities[Index : Integer]: TEntity read EntList; }
	end;

implementation

function TWorld.TransformWorldPoint;
begin
	Result := Point(Round(x * self.PaintBox.Width),
	                Round(y * self.PaintBox.Height));
end;

constructor TWorld.Create;
begin
	self.EntList := TFPObjectList.Create;
	self.EntList.OwnsObjects := true;
	
	self.FreeOnTerminate := True;
	inherited Create(true);
	
	Randomize;
end;

procedure TWorld.LinkPaintBox;
var
	i: Integer;
begin
	self.PaintBox := PaintBox;

	for i := 0 to self.EntList.Count - 1 do
		(self.EntList.Items[i] as TEntity).LinkPaintBox(PaintBox);
end;

procedure TWorld.Click;
var
	i: Integer;
	e: TEntity;
begin
	for i := 0 to self.EntList.Count - 1 do
	begin
		e := self.EntList.Items[i] as TEntity;
		
		if  (X > e.TopLeft.X) and (X < e.BottomRight.X)
		and (Y > e.TopLeft.Y) and (Y < e.BottomRight.Y) then
			e.Click;
	end;
end;

procedure TWorld.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Brush.Color := clWhite;
		FillRect(ClipRect);
	end;
end;

procedure TWorld.PaintEntities;
var
	i: Integer;
begin
	for i := 0 to self.EntList.Count - 1 do
		(self.EntList.Items[i] as TEntity).Paint;
	
	self.PaintBox.Canvas.TextOut(self.PaintBox.Width - 150, self.PaintBox.Height - 20, 'Number of entities: ' + IntToStr(self.EntList.Count));
end;

procedure TWorld.Execute;
var
	i, j: Integer;
	Now, LastThink: LongInt;
	a, b: TEntity;
begin
	LastThink := GetTickCount;

	while not self.Terminated do
	begin
		Now := GetTickCount;
		if Now - LastThink > 50 then
		begin
			{ handle touches }
			for i := 0 to self.EntList.Count - 1 do
			begin
				a := self.EntList.Items[i] as TEntity;
			
				for j := 0 to self.EntList.Count - 1 do
				begin
					if i = j then
						continue;
					
					b := self.EntList.Items[j] as TEntity;
					
					if (a.TopLeft.X < b.BottomRight.X)
					and (a.BottomRight.X > b.TopLeft.X)
					and (a.TopLeft.Y < b.BottomRight.Y)
					and (a.BottomRight.Y > b.TopLeft.Y) then
					begin
						//writeln('intersection');
						a.Touch(b);
					end;
				end;
			end;

			{ handle thinks }
			for i := 0 to self.EntList.Count - 1 do
			begin
				a := self.EntList.Items[i] as TEntity;
				a.Think;
				
				{ update entities' position }
				case a.Orientation of
					up:    a.y := a.y - a.speed * (Now - LastThink) / 1000;
					down:  a.y := a.y + a.speed * (Now - LastThink) / 1000;
					left:  a.x := a.x - a.speed * (Now - LastThink) / 1000;
					right: a.x := a.x + a.speed * (Now - LastThink) / 1000;
				end;
			end;
			
			{ delete marked entities }
			i := 0;
			while i < self.EntList.Count do
			begin
				if (self.EntList.Items[i] as TEntity).Delete then
					self.EntList.Remove(self.EntList.Items[i])
				else
					inc(i);
			end;
			
			{ redraw the scene }
			self.Synchronize(self.PaintBox.Repaint);
			
			LastThink := Now;
		end;
	end;
	
	writeln('beendet');
end;

end.
