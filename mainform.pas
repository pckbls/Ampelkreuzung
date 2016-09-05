unit MainForm;

{$mode delphi}

interface

uses
	Classes, Interfaces, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls,
	World, MyWorld;

type
	TMainForm = class(TForm)
		PaintBox: TPaintBox;
		ButtonStart: TButton;
		ButtonStop: TButton;
		ButtonClose: TBitBtn;
		
		procedure ButtonStartClick(Sender: TObject);
		procedure ButtonStopClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure PaintBoxPaint(Sender: TObject);
		procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); 
		
		private
			world: TWorld;
	end;

var
	FMain: TMainForm;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate;
begin
	self.world := TMyWorld.Create;
	self.world.LinkPaintBox(self.PaintBox);
	
	self.ButtonStop.Enabled := false;
end;

procedure TMainForm.PaintBoxPaint;
begin
	self.world.Paint;
	self.world.PaintEntities;
	
	with self.PaintBox.Canvas do
	begin
		Brush.Color := clBlack;
		Pen.Width := 1;
		
		FrameRect(ClipRect);
	end;
end;

procedure TMainForm.PaintBoxMouseUp;
begin
	self.world.Click(X / self.PaintBox.Width, Y / self.PaintBox.Height);
	self.PaintBoxPaint(Sender);
end;

procedure TMainForm.ButtonStartClick;
begin
	self.world.Start;
	
	self.ButtonStart.Enabled := false;
	self.ButtonStop.Enabled := true;
end;

procedure TMainForm.ButtonStopClick;
begin
	self.world.Terminate;
	self.world := TMyWorld.Create;
	self.world.LinkPaintBox(self.PaintBox);
	
	self.ButtonStart.Enabled := true;
	self.ButtonStop.Enabled := false;
end;

end.
