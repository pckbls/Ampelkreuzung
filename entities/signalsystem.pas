unit SignalSystem;

{$mode delphi}

interface

uses
	SysUtils, Graphics, Classes, LCLIntf, Contnrs,
	Entity, TrafficSignal;

type
	TSignalSystemState = Integer;

	TSignalSystemEntity = class(TEntity)
		protected
			LastShift: LongInt;
			SignalList: TFPObjectList;
			
			State: TSignalSystemState;
			Announced: Boolean;
			AllRed: Boolean;
			NextStateIn: LongInt;
			
			procedure Shift;
			function GetSignal(id: String): TSignalEntity;
	
		public
			constructor Create;
			function Think: Boolean; override;
			procedure AddSignal(Signal: TSignalEntity);
			
			property Signals[id: String]: TSignalEntity read GetSignal;
	end;

implementation

constructor TSignalSystemEntity.Create;
begin
	self.SignalList := TFPObjectList.Create;
	
	self.AllRed := true;
end;

procedure TSignalSystemEntity.AddSignal;
begin
	self.SignalList.Add(Signal);
end;

function TSignalSystemEntity.GetSignal;
var
	i: Integer;
	s: TSignalEntity;
begin
	for i := 0 to self.SignalList.Count - 1 do
	begin
		s := self.SignalList.Items[i] as TSignalEntity;
		if s.ID = ID then
			Result := s;
	end;
end;

function TSignalSystemEntity.Think;
var
	Now: LongInt;
begin
	Now := GetTickCount;
	if Now - self.LastShift > self.NextStateIn then
	begin
		self.Shift;
		self.LastShift := Now;
	end;

	Result := True;
end;

procedure TSignalSystemEntity.Shift;
begin
	if self.AllRed then
	begin
		self.Signals['einbahn1'].Sequence := Stop;
		self.Signals['einbahn2'].Sequence := Stop;
		
		self.Signals['haupt1'].Sequence := Stop;
		self.Signals['haupt2'].Sequence := Stop;
		
		self.Signals['fuss1'].Sequence := Stop;
		self.Signals['fuss2'].Sequence := Stop;
		self.Signals['fuss3'].Sequence := Stop;
		self.Signals['fuss4'].Sequence := Stop;
		
		self.NextStateIn := 5000;
	end
	else
	begin
		inc(self.State);
		if self.State > 2 then
			self.State := 1;
		
		case self.State of
			1: begin
				self.Signals['haupt1'].Sequence := Go;
				self.Signals['haupt2'].Sequence := Go;
				
				self.Signals['einbahn1'].Sequence := Stop;
				self.Signals['einbahn2'].Sequence := Stop;
				
				self.Signals['fuss1'].Sequence := Go;
				self.Signals['fuss2'].Sequence := Go;
				self.Signals['fuss3'].Sequence := Stop;
				self.Signals['fuss4'].Sequence := Stop;
			end;
			
			2: begin
				self.Signals['haupt1'].Sequence := Stop;
				self.Signals['haupt2'].Sequence := Stop;
				
				self.Signals['einbahn1'].Sequence := Go;
				self.Signals['einbahn2'].Sequence := Go;
				
				self.Signals['fuss1'].Sequence := Stop;
				self.Signals['fuss2'].Sequence := Stop;
				self.Signals['fuss3'].Sequence := Go;
				self.Signals['fuss4'].Sequence := Go;
			end;
		end;
		
		self.NextStateIn := 5000;
	end;
	
	self.AllRed := not self.AllRed;
end;

end.
