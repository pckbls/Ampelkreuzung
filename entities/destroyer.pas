unit Destroyer;

{$mode delphi}

interface

uses
	SysUtils, ExtCtrls, Graphics, Classes, LCLIntf,
	Entity;

type
	TDestroyEntity = class(TEntity)
		protected
			LastSpawn: LongInt;
	
		public
			procedure Paint; override;
			procedure Touch(e: TEntity); override;
	end;

implementation

procedure TDestroyEntity.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Pen.Width := 1;
		Pen.Style := psSolid;
		Pen.Color := clRed;
	
		Brush.Color := clRed;
 		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
	end;
end;

procedure TDestroyEntity.Touch;
begin
	e.Delete := true;
end;

end.
