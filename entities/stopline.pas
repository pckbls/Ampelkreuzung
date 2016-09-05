unit StopLine;

{$mode delphi}

interface

uses
	SysUtils, Graphics, Classes, LCLIntf,
	Entity, TrafficSignal;

type
	TStopLineEntity = class(TEntity)
		public
			Signal: TSignalEntity;

			procedure Paint; override;
	end;

implementation

procedure TStopLineEntity.Paint;
begin
	with self.PaintBox.Canvas do
	begin
		Pen.Width := 1;
		Pen.Style := psSolid;
		Pen.Color := clRed;
	
		Brush.Color := clRed;
//		self.DrawRectangle(-1.0, -1.0, 1.0, 1.0);
	end;
end;

end.
