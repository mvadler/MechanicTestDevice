function proyectoFinal
temperaturaFlag = 1;
ser = 0;
dimensionIndex = 0;
clave = 0;
idxdistraction = 0;
itemsdistraction = 0;
selectedItemdistraction = 0;
speedTractionVariable = 0;
maxDisplacementTractionVariable = 0;
Ndatos = 4;
selectedItemdispl = 0;
startFlag = 0;
xDimension = 0;
yDimension = 0;
loadVariable = 0;
stressVariable = 0;
displacementVariable = 0;
strainVariable = 0;
frequencyVariable = 0;
maxDisplacementDistractionVariable = 0;
cyclesVariable = 0;
active = 0;
tiempo = 0;
precarga = 0;
deformacion = 0;
tension = 0;
ud = get(0,'userdata');
ud.carga = [];
ud.time = [];
ud.delta = [];
carga = 0;
delta = 0;
time = 0;
maxtime = 5*60; %5 min de ensayo
xwindow = maxtime/10; % seconds
set(0,'userdata',ud);
global axes_one;
global axesup;
global axesone
global axes_two;
global axesdown;
global Fs;
global Ts;
global itemsdispl;
idxdispl = 0;
Ts = 0.015; %esta en segundos
Fs = 1/Ts;
f = figure('Name', 'Proyecto Final',...
    'NumberTitle', 'off',...
    'Visible', 'off',...
    'MenuBar', 'none',...
    'Position', [50 50 1453 707],...
    'Color', [1 1 1]);
buttonConnectArduino = uicontrol('style', 'pushbutton',...
                       'position', [50 650 100 40],...
                       'string', 'Conectar',...
                       'BackgroundColor', [1 1 1],...
                       'Callback', @connectArduino);
warningText = uicontrol('style', 'text',...
                       'position', [25 510 200 100],...
                       'string', 'Si quiere realizar un ensayo bajo condiciones controladas primero debe poner en temperatura la solucion con la cuba baja, colocar la muestra y luego, una vez este el sistema, subi la cuba',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off');
temperature = uicontrol('style', 'text',...
                       'position', [75 585 50 50],...
                       'string', 'Tº',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off'); 
buttonHeat = uicontrol('style', 'pushbutton',...
                       'position', [40 470 120 40],...
                       'string', 'Comenzar calentamiento',...
                       'BackgroundColor', [1 1 1],...
                        'Visible', 'off',...
                        'Callback',@startHeating);
buttonPlaceSample = uicontrol('style', 'pushbutton',...
                       'position', [50 430 100 40],...
                       'string', 'Colocar muestra',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@placeSample);  
buttonUp = uicontrol('style', 'pushbutton',...
                       'position', [180 455 40 40],...
                       'string', 'Arriba',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@upAndDown); 
buttonDown = uicontrol('style', 'pushbutton',...
                       'position', [180 405 40 40],...
                       'string', 'Abajo',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@upAndDown);
buttonSet = uicontrol('style', 'pushbutton',...
                       'position', [240 460 40 40],...
                       'string', 'Fijar',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@upAndDown); 
loadcellText = uicontrol('style', 'text',...
                       'position', [240 420 40 40],...
                       'string', 'Celda de carga [N]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
loadcellValue = uicontrol('style', 'text',...
                       'position', [240 375 40 40],...
                       'string', ' - ',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off'); 
loadcellValueUnit = uicontrol('style', 'text',...
                       'position', [280 375 40 40],...
                       'string', ' N ',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off'); 
readyText = uicontrol('style', 'text',...
                       'position', [40 470 120 40],...
                       'string', 'Listo!',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
dimensionsText = uicontrol('style', 'text',...
                       'position', [50 390 120 30],...
                       'string', 'Dimensiones de la muestra [mm]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off'); 
editXDimension = uicontrol('style', 'edit',...
                       'position', [60 370 40 20],...
                       'string', 'X',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@placeSample); 
editYDimension = uicontrol('style', 'edit',...
                       'position', [100 370 40 20],...
                       'string', 'Y',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@placeSample); 
buttonChooseRoutine = uicontrol('style', 'pushbutton',...
                       'position', [60 300 100 40],...
                       'string', 'Elegir rutina',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@chooseRoutine);
traction = uicontrol('style', 'pushbutton',...
                       'position', [160 345 100 20],...
                       'string', 'Traccion',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@tractionTest);
creep = uicontrol('style', 'pushbutton',...
                       'position', [160 320 100 20],...
                       'string', 'Creep',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@creepTest);
relaxation = uicontrol('style', 'pushbutton',...
                       'position', [160 295 100 20],...
                       'string', 'Relajacion',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@relaxationTest); 
distraction = uicontrol('style', 'pushbutton',...
                       'position', [160 270 100 20],...
                       'string', '(Dis) traccion',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@distractionTest);
speed = uicontrol('style', 'text',...
                       'position', [175 600 55 30],...
                       'string', 'Velocidad',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off');
frequency = uicontrol('style', 'text',...
                       'position', [172 600 60 30],...
                       'string', 'Frecuencia',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off');
setCycles = uicontrol('style', 'edit',...
                       'position', [245 580 52 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@distractionTest);
cycles = uicontrol('style', 'text',...
                       'position', [230 610 80 20],...
                       'string', 'Ciclos',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off'); 
optionalText2 = uicontrol('style', 'text',...
                       'position', [247 550 50 20],...
                       'string', 'opcional',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');  
setFrequency = uicontrol('style', 'popupmenu',...
                       'position', [175 580 50 20],...
                       'String', {'Ingrese frecuencia','0.5','0.571429','0.666','0.8','0.888','1','1.142857','1.333','1.6','1.777','2','2.285714','2.666','3.2','3.555','4','4.571429'},...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@distractionTest);
speedUnit = uicontrol('style', 'text',...
                       'position', [175 555 50 20],...
                       'string', '[mm/min]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
frequencyUnit = uicontrol('style', 'text',...
                       'position', [175 555 50 20],...
                       'string', '[Hz]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off'); 
setSpeedTraction = uicontrol('style', 'popupmenu',...
                       'position', [175 580 50 20],...
                       'string', {'Ingrese velocidad','10','20','40','80','160','320'},...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@tractionTest);
maxDisplacementText = uicontrol('style', 'text',...
                       'position', [310 610 85 30],...
                       'string', 'Maximo desplazamiento',...
                       'FontWeight', 'bold',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
maxDisplacementDistraction = uicontrol('style', 'popupmenu',...
                       'position', [320 580 50 20],...
                       'string', 'A definir',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@distractionTest);
maxDisplacementUnit = uicontrol('style', 'text',...
                       'position', [320 555 50 20],...
                       'string', '[mm]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
maxDisplacementTraction = uicontrol('style', 'edit',...
                       'position', [320 580 50 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@tractionTest);
optionalText = uicontrol('style', 'text',...
                       'position', [320 530 50 20],...
                       'string', 'opcional',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');           
load = uicontrol('style', 'checkbox',...
                       'position', [185 620 50 20],...
                       'string', 'Carga',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off',...
                       'Callback',@loadCheckbox); 
setLoad = uicontrol('style', 'edit',...
                       'position', [185 590 52 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@creepTest);
loadUnit = uicontrol('style', 'text',...
                       'position', [185 565 52 20],...
                       'string', '[N]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off'); 
stress = uicontrol('style', 'checkbox',...
                       'position', [280 620 60 20],...
                       'FontWeight', 'bold',...
                       'string', 'Tension',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@stressCheckbox); 
setStress = uicontrol('style', 'edit',...
                       'position', [280 590 52 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@creepTest);
stressUnit = uicontrol('style', 'text',...
                       'position', [280 565 52 20],...
                       'string', '[MPa]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
tractionTitle = uicontrol('style', 'text',...
                       'position', [220 650 100 20],...
                       'string', 'Traccion',...
                       'FontWeight', 'bold',...
                       'FontSize',14.0,...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
displacement = uicontrol('style', 'checkbox',...
                       'position', [170 620 110 20],...
                       'string', 'Desplazamiento',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off',...
                       'Callback',@displacementCheckbox); 
setDisplacement = uicontrol('style', 'edit',...
                       'position', [180 590 52 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@relaxationTest);
displacementUnit = uicontrol('style', 'text',...
                       'position', [180 565 52 20],...
                       'string', '[mm]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
strain = uicontrol('style', 'checkbox',...
                       'position', [290 620 130 20],...
                       'string', 'Deformacion unitaria',...
                       'BackgroundColor', [1 1 1],...
                       'FontWeight', 'bold',...
                       'Visible', 'off',...
                       'Callback',@strainCheckbox); 
setStrain = uicontrol('style', 'edit',...
                       'position', [290 590 52 20],...
                       'string', '- -',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@relaxationTest);
strainUnit = uicontrol('style', 'text',...
                       'position', [290 565 52 20],...
                       'string', '[mm/mm]',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
relaxationTitle = uicontrol('style', 'text',...
                       'position', [200 650 100 20],...
                       'string', 'Relajacion',...
                       'FontWeight', 'bold',...
                       'FontSize',14.0,...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
creepTitle = uicontrol('style', 'text',...
                       'position', [200 650 100 20],...
                       'string', 'Creep',...
                       'FontWeight', 'bold',...
                       'FontSize',14.0,...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
distractionTitle = uicontrol('style', 'text',...
                       'position', [190 650 200 20],...
                       'string', 'Traccion - Distraccion',...
                       'FontWeight', 'bold',...
                       'FontSize',14.0,...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off');
buttonStart = uicontrol('style', 'pushbutton',...
                       'position', [220 420 100 40],...
                       'string', 'Comenzar',...
                       'BackgroundColor', [1 1 1],...
                       'ForegroundColor',[0.3 0.75 0.93],...
                       'Visible', 'off',...
                       'Callback',@start);
buttonSave = uicontrol('style', 'pushbutton',...
                       'position', [220 360 100 40],...
                       'string', 'Guardar',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@save);
buttonChooseAnotherRoutine = uicontrol('style', 'pushbutton',...
                       'position', [180 680 150 20],...
                       'string', 'Elegir otra rutina',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@chooseAnotherRoutine);
buttonAdjustSamplePlacement = uicontrol('style', 'pushbutton',...
                       'position', [60 215 150 40],...
                       'string', 'Ajustar posicion de la muestra',...
                       'BackgroundColor', [1 1 1],...
                       'Visible', 'off',...
                       'Callback',@adjustSamplePlacement);

handles = guihandles(f);
% Move the window to the center of the screen.
movegui(f, 'center');
% Make the window visible.
f.Visible = 'on';
%axesdown = animatedline('Color','b');
%Functions
    function bytes = convert2bytes(valor)
        byte3 = bitshift(valor,-16);
        if(valor<256)
            byte2 = 0;
        else
            if(valor<65536)
                byte2 = floor(valor/256);
            else
                byte2 = floor(rem((valor/256),256));
            end
        end
        byte1 = rem(valor,256);
        bytes = [byte3,byte2,byte1];
    end

    function connectArduino(source, eventdata)
        switch source.String
            case 'Conectar'
                if ispc
                    definput = {'COM4'};
                elseif ismac 
                    definput = {'/dev/cu.usbmodem1411'};
                else 
                    disp('Plataform not supported');
                end
                prompt = {'Puerto:'};
                title = 'Conectar';
                dims = [1 50];
                answer = inputdlg(prompt,title,dims,definput);
                if ~isempty(answer)
%                     ser = serial(answer{1}, 'baudrate',115200, 'timeout',10);
%                     fopen(ser);
%                     pause(1);
                    source.String = 'Desconectar';
                    warningText.Visible = 'on';
                    buttonHeat.Visible = 'on';
                    buttonPlaceSample.Visible = 'on';
                end
                if isempty(instrfind)
                    warndlg('Arduino no conectado', 'Ups');
                    return
                end
            case 'Desconectar'
                clave = 6;
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,255);
%                 fwrite(ser,clave);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
                temperaturaFlag = false;
                source.String = 'Conectar';
                buttonPlaceSample.Visible = 'off';
                buttonHeat.Visible = 'off';
                readyText.Visible = 'off';
                warningText.Visible = 'off';
                buttonDown.Visible = 'off';
                buttonUp.Visible = 'off';
                buttonChooseRoutine.Visible = 'off';
                editXDimension.Visible = 'off';
                editYDimension.Visible = 'off';
                dimensionsText.Visible = 'off';
                traction.Visible = 'off';
                creep.Visible = 'off';
                relaxation.Visible = 'off';
                distraction.Visible = 'off';
                tractionTitle.Visible = 'off';
                setSpeedTraction.Visible = 'off';
                speed.Visible = 'off';
                buttonStart.Visible = 'off';
                setLoad.Visible = 'off';
                load.Visible = 'off';
                optionalText.Visible = 'off';
                relaxationTitle.Visible = 'off';
                creepTitle.Visible = 'off';
                displacement.Visible = 'off';
                setDisplacement.Visible = 'off';
                setLoad.Visible = 'off';
                buttonAdjustSamplePlacement.Visible = 'off';
                buttonChooseAnotherRoutine.Visible = 'off';
                buttonUp.Visible = 'off';
                buttonDown.Visible = 'off';
                buttonSet.Visible = 'off';
                loadcellValue.Visible = 'off';
                loadcellText.Visible = 'off';
                maxDisplacementText.Visible = 'off';
                maxDisplacementTraction.Visible = 'off';
                maxDisplacementDistraction.Visible = 'off';
                distractionTitle.Visible = 'off';
                strain.Visible = 'off';
                setStrain.Visible = 'off';
                stress.Visible = 'off';
                setStress.Visible = 'off';
                buttonHeat.String = 'Comenzar calentamiento';
                temperature.Visible = 'off';
                buttonSave.Visible = 'off';
                displacementUnit.Visible = 'off';
                stressUnit.Visible = 'off';
                strainUnit.Visible = 'off';
                speedUnit.Visible = 'off';
                loadUnit.Visible = 'off';
                maxDisplacementUnit.Visible = 'off';
                loadcellValue.String = " - ";
                loadcellValueUnit.Visible = 'off';
                setSpeedTraction.String = "- -";
                maxDisplacementTraction.String = '- -';
                maxDisplacementDistraction.String = '- -';
                setCycles.Visible = 'off';
                cycles.Visible = 'off';
                optionalText2.Visible = 'off';
                frequency.Visible = 'off';
                setFrequency.String = '- -';
                frequencyUnit.Visible = 'off';
                setFrequency.Visible = 'off';
                setCycles.String = '- -';
                strain.Value = 0;
                displacement.Value = 0;
                setDisplacement.String = '- -';
                setLoad.String = '- -';
                load.Value = 0;
                xDimension = 0;
                yDimension = 0;
                dimensionIndex = 0;
                delete(instrfind)      
        end
%         if isempty(instrfind)
%             warndlg('Arduino no conectado', 'Ups');
%             return
%         end
    end


    function startHeating(source, eventdata)
    warningText.Visible = 'off';
    buttonPlaceSample.Visible = 'off';
    temperature.Visible = 'on';
    buttonHeat.String = 'Calentando...';
    clave = 4;
%     fwrite(ser,1);
%     fwrite(ser,1);
%     fwrite(ser,1);
%     fwrite(ser,1);
%     fwrite(ser,1);
%     fwrite(ser,255);
%     fwrite(ser,clave);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
%     fwrite(ser,0);
    while(temperaturaFlag)
        datos = fread(ser,1);
        if(datos == 4)
            temperaturaFlag = false;
        end
    end
    readyText.Visible = 'on';
    buttonPlaceSample.Visible = 'on';
    buttonHeat.Visible = 'off';
    end 


    function placeSample(source, eventdata)
        buttonHeat.Visible = 'off';
        buttonUp.Visible = 'on';
        buttonDown.Visible = 'on';
        buttonSet.Visible = 'on';
        loadcellValue.Visible = 'on';
        loadcellValueUnit.Visible = 'on';
        loadcellText.Visible = 'on';
        dimensionsText.Visible = 'on';
        editXDimension.Visible = 'on';
        editYDimension.Visible = 'on';
        buttonChooseRoutine.Visible = 'on';
        readyText.Visible = 'off';

        xDimension = str2double(editXDimension.String);
        yDimension = str2double(editYDimension.String);
        if (xDimension > 0 && yDimension > 0 && ~isnan(xDimension) && ~isnan(yDimension))
            dimensionIndex = 1;
        end
    end 

    function chooseRoutine(source, eventdata)
        buttonPlaceSample.Visible = 'off';
        buttonUp.Visible = 'off';
        buttonDown.Visible = 'off';
        buttonSet.Visible = 'off';
        loadcellValue.Visible = 'off';
        loadcellValueUnit.Visible = 'off';
        loadcellText.Visible = 'off';
        traction.Visible = 'on';
        creep.Visible = 'on';
        relaxation.Visible = 'on';
        distraction.Visible = 'on';
        dimensionsText.Visible = 'off';
        editXDimension.Visible = 'off';
        editYDimension.Visible = 'off';
        warningText.Visible = 'off';
    end

    function tractionTest(source, eventdata)
        setSpeedTraction.Visible = 'on';
        speed.Visible = 'on';
        speedUnit.Visible = 'on';
        maxDisplacementUnit.Visible = 'on';
        buttonStart.Visible = 'on';
        tractionTitle.Visible = 'on';
        buttonChooseRoutine.Visible = 'off';
        traction.Visible = 'off';
        creep.Visible = 'off';
        relaxation.Visible = 'off';
        distraction.Visible = 'off';
        buttonChooseAnotherRoutine.Visible = 'on';
        buttonAdjustSamplePlacement.Visible = 'off';
        buttonPlaceSample.Visible = 'off';
        buttonUp.Visible = 'off';
        buttonDown.Visible = 'off';
        buttonSet.Visible = 'off';
        loadcellValue.Visible = 'off';
        loadcellValueUnit.Visible = 'off';
        loadcellText.Visible = 'off';
        optionalText.Visible = 'on';
        maxDisplacementText.Visible = 'on';
        maxDisplacementTraction.Visible = 'on';
        dimensionsText.Visible = 'off';
        editXDimension.Visible = 'off';
        editYDimension.Visible = 'off';

        clave = 10;
        startFlag = 0;
        idxtraction = setSpeedTraction.Value;
        itemstraction = setSpeedTraction.String;
        selectedItemtraction = itemstraction{idxtraction};
        speedTractionVariable = str2double(selectedItemtraction);
        maxDisplacementTractionVariable = str2double(maxDisplacementTraction.String);
    end

    function loadCheckbox(source, eventdata)
        value = load.Value;
        if value
            setLoad.Visible = 'on';
            loadUnit.Visible = 'on';
            setStress.Visible = 'off';
            stressUnit.Visible = 'off';
            stress.Value = 0;
        else
            setLoad.Visible = 'off';
            loadUnit.Visible = 'off';
            setStress.Visible = 'on';
            stressUnit.Visible = 'on';
            stress.Value = 1;
        end
    end

    function strainCheckbox(source, eventdata)
        value = strain.Value;
            if value
                setStrain.Visible = 'on';
                strainUnit.Visible = 'on';
                setDisplacement.Visible = 'off';
                displacementUnit.Visible = 'off';
                displacement.Value = 0;
            else
                setStrain.Visible = 'off';
                strainUnit.Visible = 'off';
                setDisplacement.Visible = 'on';
                displacementUnit.Visible = 'on';
                displacement.Value = 1;
            end
    end 

    function stressCheckbox(source, eventdata)
        value = stress.Value;
        if value
            setStress.Visible = 'on';
            stressUnit.Visible = 'on';
            setLoad.Visible = 'off';
            loadUnit.Visible = 'off';
            load.Value = 0;
        else
            setStress.Visible = 'off';
            stressUnit.Visible = 'off';
            setLoad.Visible = 'on';
            loadUnit.Visible = 'on';
            load.Value = 1;
        end
    end

    function displacementCheckbox(source, eventdata)
    value = displacement.Value;
        if value
            setDisplacement.Visible = 'on';
            displacementUnit.Visible = 'on';
            setStrain.Visible = 'off';
            strainUnit.Visible = 'off';
            strain.Value = 0;
        else
            setDisplacement.Visible = 'off';
            displacementUnit.Visible = 'off';
            setStrain.Visible = 'on';
            strainUnit.Visible = 'on';
            strain.Value = 1;
        end
    end

    function creepTest(source, eventdata)
    stress.Visible = 'on';
    load.Visible = 'on';
    buttonStart.Visible = 'on';
    creepTitle.Visible = 'on';
    buttonChooseRoutine.Visible = 'off';
    traction.Visible = 'off';
    creep.Visible = 'off';
    relaxation.Visible = 'off';
    distraction.Visible = 'off';
    buttonChooseAnotherRoutine.Visible = 'on';
    buttonAdjustSamplePlacement.Visible = 'off';
    buttonPlaceSample.Visible = 'off';
    buttonUp.Visible = 'off';
    buttonDown.Visible = 'off';
    buttonSet.Visible = 'off';
    loadcellValue.Visible = 'off';
    loadcellValueUnit.Visible = 'off';
    loadcellText.Visible = 'off';
    dimensionsText.Visible = 'off';
    editXDimension.Visible = 'off';
    editYDimension.Visible = 'off';
    
    clave = 20;
    startFlag = 0;
    loadVariable = str2double(setLoad.String);
    stressVariable = str2double(setStress.String);
    end

    function relaxationTest(hObject, eventdata)
    displacement.Visible = 'on';
    strain.Visible = 'on';
    relaxationTitle.Visible = 'on';
    buttonChooseAnotherRoutine.Visible = 'on';
    buttonStart.Visible = 'on';
    buttonChooseRoutine.Visible = 'off';
    traction.Visible = 'off';
    creep.Visible = 'off';
    relaxation.Visible = 'off';
    distraction.Visible = 'off';
    buttonAdjustSamplePlacement.Visible = 'off';
    buttonPlaceSample.Visible = 'off';
    buttonUp.Visible = 'off';
    buttonDown.Visible = 'off';
    buttonSet.Visible = 'off';
    loadcellValue.Visible = 'off';
    loadcellValueUnit.Visible = 'off';
    loadcellText.Visible = 'off';
    dimensionsText.Visible = 'off';
    editXDimension.Visible = 'off';
    editYDimension.Visible = 'off';

    clave = 30;
    startFlag = 0;
    displacementVariable = str2double(setDisplacement.String);
    strainVariable = str2double(setStrain.String);
    end

    function distractionTest(source, eventdata)
    frequencyUnit.Visible = 'on';
    frequency.Visible = 'on';
    setFrequency.Visible = 'on';
    cycles.Visible = 'on';
    optionalText2.Visible = 'on';
    setCycles.Visible = 'on';
    maxDisplacementUnit.Visible = 'on';
    maxDisplacementDistraction.Visible = 'on';
    maxDisplacementText.Visible = 'on';
    buttonStart.Visible = 'on';
    distractionTitle.Visible = 'on';
    buttonChooseRoutine.Visible = 'off';
    traction.Visible = 'off';
    creep.Visible = 'off';
    relaxation.Visible = 'off';
    distraction.Visible = 'off';
    buttonChooseAnotherRoutine.Visible = 'on';
    buttonAdjustSamplePlacement.Visible = 'off';
    buttonPlaceSample.Visible = 'off';
    buttonUp.Visible = 'off';
    buttonDown.Visible = 'off';
    buttonSet.Visible = 'off';
    loadcellValue.Visible = 'off';
    loadcellValueUnit.Visible = 'off';
    loadcellText.Visible = 'off';
    dimensionsText.Visible = 'off';
    editXDimension.Visible = 'off';
    editYDimension.Visible = 'off';

    clave = 40;
    startFlag = 0;
    idxdistraction = setFrequency.Value
    itemsdistraction = setFrequency.String
    selectedItemdistraction = itemsdistraction{idxdistraction}
    frequencyVariable = str2double(selectedItemdistraction);
    if(~isnan(frequencyVariable))
        if(frequencyVariable == 0.5)
            maxDisplacementDistraction.String = {'Elija desplazamiento','40','20'};
        else
            if(frequencyVariable == 0.571429)
                maxDisplacementDistraction.String = {'Elija desplazamiento','45'};
            else
                if(frequencyVariable == 0.666)
                    maxDisplacementDistraction.Value = 1;
                    maxDisplacementDistraction.String = {'Elija desplazamiento','30','15'};
                else
                    if(frequencyVariable == 0.8)
                        maxDisplacementDistraction.String = {'Elija desplazamiento','50','25'};
                    else
                        if(frequencyVariable == 0.888)
                            maxDisplacementDistraction.String = {'Elija desplazamiento','45'};
                        else
                            if(frequencyVariable == 1)
                                maxDisplacementDistraction.String = {'Elija desplazamiento','40','20','10'};
                            else
                                if(frequencyVariable == 1.142857)
                                    idxdispl = 1;
                                    maxDisplacementDistraction.String = {'Elija desplazamiento','35'};
                                else
                                    if(frequencyVariable == 1.333)
                                        maxDisplacementDistraction.String = {'Elija desplazamiento','30','15'};
                                    else
                                        if(frequencyVariable == 1.6)
                                            maxDisplacementDistraction.String = {'Elija desplazamiento','50','20'};
                                        else
                                            if(frequencyVariable == 1.777)
                                                maxDisplacementDistraction.String = {'Elija desplazamiento','45'};
                                            else
                                                if(frequencyVariable == 2)
                                                    maxDisplacementDistraction.String = {'Elija desplazamiento','40','20','10','5'};
                                                else
                                                    if(frequencyVariable == 2.285717)
                                                        maxDisplacementDistraction.String = {'Elija desplazamiento','35'};
                                                    else
                                                        if(frequencyVariable == 2.666)
                                                            maxDisplacementDistraction.String = {'Elija desplazamiento','30','15'};
                                                        else
                                                            if(frequencyVariable == 3.2)
                                                                maxDisplacementDistraction.String = {'Elija desplazamiento','50','25'};
                                                            else
                                                                if(frequencyVariable == 3.555)
                                                                    maxDisplacementDistraction.String = {'Elija desplazamiento','45'};
                                                                else
                                                                    if(frequencyVariable == 4)
                                                                        maxDisplacementDistraction.String = {'Elija desplazamiento','40','20','10','5'};
                                                                    else
                                                                        if(frequencyVariable == 4.571429)
                                                                            maxDisplacementDistraction.String = {'Elija desplazamiento','35'};
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
    end
    if(idxdispl > length(maxDisplacementDistraction.String))
        idxdispl = 1
    else
        idxdispl = maxDisplacementDistraction.Value
    end
    itemsdispl = maxDisplacementDistraction.String
    selectedItemdispl = itemsdispl{idxdispl}
    frequencyVariable = str2double(selectedItemdistraction)
    maxDisplacementDistractionVariable = str2double(selectedItemdispl)
    cyclesVariable = str2double(setCycles.String);
    end
end

    function start(source, eventdata)
    active = 0;
    startFlag = 1;
    
    %la clave determina que ensayo va a realizarse
    switch source.String
        case 'Comenzar'
            source.String = 'Parar';
            buttonStart.ForegroundColor =[1 0 0];
            buttonChooseAnotherRoutine.Visible = 'off';
            buttonConnectArduino.Visible = 'off';
            buttonSave.Visible = 'off';
            active = 1;
        case 'Parar'
            active = 0;
            fwrite(ser,1);
            fwrite(ser,1);
            fwrite(ser,1);
            fwrite(ser,1);
            fwrite(ser,1);
            fwrite(ser,255);
            fwrite(ser,9);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            fwrite(ser,0);
            source.String = 'Comenzar';
            set(axes_one, 'Visible','off')
            set(axesone, 'Visible','off')
            if(clave == 40 || clave == 30 || clave == 20)
                set(axes_two, 'Visible','off')
                set(axesup, 'Visible','off')
                if(clave == 40)
                    set(axesdown, 'Visible','off')
                end
            end
            buttonStart.ForegroundColor =[0.3 0.75 0.93];
            buttonChooseAnotherRoutine.Visible = 'on';
            buttonConnectArduino.Visible = 'on';
            buttonSave.Visible = 'on';
            startFlag = 0;
            ud = get(0,'userdata');
            ud.time = time';
            ud.carga = carga';
            ud.delta = delta';
            set(0,'userdata',ud);
            legend('hide')
            tiempo = zeros(1,(Ndatos-2)/2);
    end 
    if startFlag
        switch clave
            case 10 %traccion
                if (isnan(speedTractionVariable) || speedTractionVariable == 0)
                    warndlg('Ingrese la velocidad', 'Faltan valores');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                end
                if (~isnan(maxDisplacementTractionVariable) && maxDisplacementTractionVariable < 0)
                    warndlg('Reingrese el desplazamiento maximo', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                end
                if (speedTractionVariable < 0.05 || speedTractionVariable >  1000)
                    warndlg('Velocidad fuera de rango', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    set(axes_one, 'Visible','off')
                    axis off;
                    return
                end
                if (maxDisplacementTractionVariable < 0.5 || maxDisplacementTractionVariable >  50)
                    warndlg('Desplazamiento fuera de rango', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    set(axes_one, 'Visible','off')
                    axis off;
                    return
                end
                axes_one = axes('Position',[0.32 0.1 0.65 0.8]);
                axesone = animatedline('Color','r');
                if(dimensionIndex)                
                    xlabel('\epsilon (mm/mm)')
                    ylabel('\sigma (MPa)')
                else
                    xlabel('\Delta x (mm)')
                    ylabel('T (N)')
                end
                pulseSpeed = (speedTractionVariable * 360 * 10)/(0.0144 * 60 * 5);
                pulseSpeed = round(pulseSpeed);
                conversion = convert2bytes(pulseSpeed);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,255);
                fwrite(ser, clave);
                fwrite(ser, conversion(3));
                fwrite(ser, conversion(2));
                fwrite(ser, conversion(1));
                if(~isnan(maxDisplacementTractionVariable) || maxDisplacementTractionVariable == 0)
                    fwrite(ser, 11);%voy a poner 10 cuando no se manda mas 
                    %info y 11 cuando se manda despl maximo
                    maxDispl = round(maxDisplacementTractionVariable*10000);
                    %paso a um
                    maxDispl = maxDispl/2; %esto me da la cantidad de pasos
                    %maximos que puede hacer %2 es el paso en um
                    array = convert2bytes(maxDispl);
                    fwrite(ser, array(3));
                    fwrite(ser, array(2));
                    fwrite(ser, array(1));
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                else
                    fwrite(ser,12);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    %voy a poner 10 cuando no se manda mas info y 11 cuando
                    %se manda despl maximo
                end
                while active
                    input = fread(ser,Ndatos,'int32')';% Datos entrantes
                    if isempty(input)
                        continue;
                    end
                    checker1 = input(1);
                    checker2 = input(4);
                    if( checker1 ~= 255 && checker2 ~= 255)
                        continue;
                    end
                    if(dimensionIndex)
                        deformacion = (input(2)*0.0002)/yDimension;
                        tension = (input(3)-precarga)/(100*yDimension*xDimension);
                    else
                        deformacion = input(2)*0.0002;
                        tension = (input(3)-precarga)/100;
                    end
                    tiempo = tiempo + Ts;
                    addpoints(axesone,deformacion,tension);
                    drawnow; 
                    delta = [delta deformacion];
                    carga = [carga tension];
                    time = [time tiempo];
                end
            case 20 %creep
                if (1)
                    warndlg('Este ensayo no se encuentra disponible', 'Realice otro ensayo');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                end
%                 if (~isnan(loadVariable) && loadVariable < 0)
%                     warndlg('Reingrese la carga', 'Valor inaceptable');
%                     startFlag = 0;
%                     buttonStart.String = 'Comenzar';
%                     buttonStart.ForegroundColor = [0.3 0.75 0.93];
%                     buttonChooseAnotherRoutine.Visible = 'on';
%                     buttonConnectArduino.Visible = 'on';
%                     return
%                 end
%                 if (loadVariable < 0.1 || loadVariable >  500)
%                     warndlg('Carga fuera de rango', 'Valor inaceptable');
%                     startFlag = 0;
%                     buttonStart.String = 'Comenzar';
%                     buttonStart.ForegroundColor = [0.3 0.75 0.93];
%                     buttonChooseAnotherRoutine.Visible = 'on';
%                     buttonConnectArduino.Visible = 'on';
%                     set(axes_one, 'Visible','off')
%                     axis off;
%                     return
%                 end
%                 axes_one = axes('Position',[0.32 0.55 0.65 0.35]);
%                 axesone = animatedline('Color','r');
%                 xlabel('Tiempo (s)')
%                 if(dimensionIndex)
%                     ylabel('\sigma (MPa)')
%                 else
%                     ylabel('T (N)')
%                 end
% 
%                 axes_two = axes('Position',[0.32 0.1 0.65 0.35]);
%                 axesup = animatedline('Color','b');
%                 xlabel('Tiempo (s)')
%                 if(dimensionIndex)
%                     ylabel('\epsilon (mm/mm)')
%                 else
%                     ylabel('\Delta x (mm)')
%                 end
%                 variables = loadVariable;
%                 if(dimensionIndex)
%                     variableCarga = round(stressVariable*1000*yDimension*xDimension); %aca deberia haber
%                 %un *10 por mandar con 1 decimal y un /10 por mandar
%                 %masa y no peso y *1000 para mandar en gramos
%                 %aca stress lo multiplico por el area y lo trato como
%                 %tension normal en N
%                 else
%                     variableCarga = round(loadVariable*1000); %aca deberia haber
%                 %un *10 por mandar con 1 decimal y un /10 por mandar
%                 %masa y no peso y *1000 para mandar en gramos
%                 end
%                 loadArray = convert2bytes(variableCarga);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,1);
%                 fwrite(ser,255);
%                 fwrite(ser, clave);
%                 fwrite(ser, loadArray(3));
%                 fwrite(ser, loadArray(2));
%                 fwrite(ser, loadArray(1));
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 fwrite(ser,0);
%                 while active
%                     input = fread(ser,Ndatos,'int32');% Datos entrantes  
%                     if isempty(input)
%                         continue;
%                     end
%                     checker1 = input(1);
%                     checker2 = input(4);
%                     if( checker1 ~= 255 && checker2 ~= 255)
%                         continue;
%                     end
%                     if(dimensionIndex)
%                         deformacion = (input(2)*0.0002)/yDimension;
%                         tension = (input(3)-precarga)/(100*yDimension*xDimension);
%                     else
%                         deformacion = input(2)*0.0002;
%                         tension = (input(3)-precarga)/100;
%                     end
%                     tiempo = tiempo + Ts;
%                     addpoints(axesone,tiempo,deformacion);
%                     drawnow; 
%                     addpoints(axesup,tiempo,tension);
%                     drawnow;
%                     delta = [delta deformacion];
%                     carga = [carga tension];
%                     time = [time tiempo];
%                 end
            case 30 %%relajacion
                if(dimensionIndex)
                    if (~isnan(strainVariable) && strainVariable < 0)
                        warndlg('Reingrese el desplazamiento maximo', 'Valor inaceptable');
                        startFlag = 0;
                        buttonStart.String = 'Comenzar';
                        buttonStart.ForegroundColor = [0.3 0.75 0.93];
                        buttonChooseAnotherRoutine.Visible = 'on';
                        buttonConnectArduino.Visible = 'on';
                        return
                    end
                else
                    if (~isnan(displacementVariable) && displacementVariable < 0)
                    warndlg('Reingrese el desplazamiento maximo', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                    end
                    if (displacementVariable < 0.5 || displacementVariable >  40)
                        warndlg('Desplazamiento fuera de rango', 'Valor inaceptable');
                        startFlag = 0;
                        buttonStart.String = 'Comenzar';
                        buttonStart.ForegroundColor = [0.3 0.75 0.93];
                        buttonChooseAnotherRoutine.Visible = 'on';
                        buttonConnectArduino.Visible = 'on';
                        set(axes_one, 'Visible','off')
                        axis off;
                        return
                    end
                end
                if(dimensionIndex)
                    variableMaxDispl = round(strainVariable*yDimension*10000); 
                else
                    variableMaxDispl = round(displacementVariable*10000);
                end
                %pasado a um
                variableMaxDispl = variableMaxDispl/2; %esto me da la canti
                %dad de pasos maximos que puede hacer %2 es el paso en um
                array = convert2bytes(variableMaxDispl);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,255);
                fwrite(ser, clave);
                fwrite(ser, array(3));
                fwrite(ser, array(2));
                fwrite(ser, array(1));
                fwrite(ser,0);
                fwrite(ser,0);
                fwrite(ser,0);
                fwrite(ser,0);
                fwrite(ser,0);
                fwrite(ser,0);
                fwrite(ser,0);
                axes_one = axes('Position',[0.32 0.55 0.65 0.35],'XLim',[0 maxtime],'YLim',[0 displacementVariable]);
                axesone = animatedline('Color','r');
                xlabel('Tiempo (s)')
                if(dimensionIndex)
                    ylabel('\epsilon (mm/mm)')
                else
                    ylabel('\Delta x (mm)')
                end
                axes_two = axes('Position',[0.32 0.1 0.65 0.35],'XLim',[0 maxtime]);
                axesup = animatedline('Color','b');
                if(dimensionIndex)
                    xlabel('Tiempo (s)')
                    ylabel('\sigma (MPa)')
                else
                    xlabel('Tiempo (s)')
                    ylabel('T (N)')
                end
                while active
                    input = fread(ser,Ndatos,'int32')';% Datos entrantes
                    if isempty(input)
                        continue;
                    end
                    checker1 = input(1);
                    checker2 = input(4);
                    if( checker1 ~= 255 && checker2 ~= 255)
                        continue;
                    end
                    if(dimensionIndex)
                        deformacion = (input(2)*0.0002)/yDimension;
                        tension = (input(3)-precarga)/(100*yDimension*xDimension);
                    else
                        deformacion = input(2)*0.0002;
                        tension = (input(3)-precarga)/100;
                    end
                    tiempo = tiempo + Ts;
                    addpoints(axesone,tiempo,deformacion);
                    drawnow; 
                    addpoints(axesup,tiempo,tension);
                    drawnow
                    delta = [delta deformacion];
                    carga = [carga tension];
                    time = [time tiempo];
                end
            case 40 %traccion - distraccion
                if (~isnan(maxDisplacementDistractionVariable) && maxDisplacementDistractionVariable < 0)
                    warndlg('Reingrese el desplazamiento maximo', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                end
                if (~isnan(frequencyVariable) && frequencyVariable < 0)
                    warndlg('Reingrese el desplazamiento maximo', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    return
                end
                if (maxDisplacementDistractionVariable < 0.5 || maxDisplacementDistractionVariable >  50)
                    warndlg('Desplazamiento fuera de rango', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    set(axes_one, 'Visible','off')
                    axis off;
                    return
                end
                if (frequencyVariable < 0.1 || frequencyVariable >  5)
                    warndlg('Frecuencia fuera de rango', 'Valor inaceptable');
                    startFlag = 0;
                    buttonStart.String = 'Comenzar';
                    buttonStart.ForegroundColor = [0.3 0.75 0.93];
                    buttonChooseAnotherRoutine.Visible = 'on';
                    buttonConnectArduino.Visible = 'on';
                    set(axes_one, 'Visible','off')
                    axis off;
                    return
                end
                
                periodo = 1/frequencyVariable; %esto esta en segundos
                periodo = periodo/(2*60); %esta en minutos
                velocidad = maxDisplacementDistractionVariable/periodo;
                %esta en mm/min
                frecuenciaVelocidad = (velocidad * 360 * 10)/(0.0144 * 60 * 5);
                frecuenciaVelocidad = round(frecuenciaVelocidad);
                frecuenciaVelocidadArray = convert2bytes(frecuenciaVelocidad);
                variableMaxDispl = round(maxDisplacementDistractionVariable*10000); 
                %pasado a um
                variableMaxDispl = variableMaxDispl/2; %esto me da la 
                %cantidad de pasos maximos que puede hacer %2 es el paso en
                %um
                array = convert2bytes(variableMaxDispl);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,1);
                fwrite(ser,255);
                fwrite(ser, clave);
                fwrite(ser, frecuenciaVelocidadArray(3));
                fwrite(ser, frecuenciaVelocidadArray(2));
                fwrite(ser, frecuenciaVelocidadArray(1));
                fwrite(ser, array(3));
                fwrite(ser, array(2));
                fwrite(ser, array(1));
                if(~isnan(cyclesVariable) || cyclesVariable == 0)
                    fwrite(ser, 41);%voy a poner 41 cuando se manda despl 
                    %maximo
                    ciclos = round(cyclesVariable);
                    aregloCiclos = convert2bytes(ciclos);
                    fwrite(ser, aregloCiclos(3));
                    fwrite(ser, aregloCiclos(2));
                    fwrite(ser, aregloCiclos(1));
                else
                    fwrite(ser,42); %voy a poner 42 cuando no se manda mas 
                    %info
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                end
                
                axes_one = axes('Position',[0.32 0.55 0.65 0.35],'XLim',[0 maxDisplacementDistractionVariable]);
                axesone = animatedline('Color','r'); %,'MaximumNumPoints',maxpoints);
                if(dimensionIndex)
                    xlabel('\epsilon (mm/mm)')
                    ylabel('\sigma (MPa)')
                else
                    xlabel('\Delta x (mm)')
                    ylabel('T (N)')
                end
                axes_two = axes('Position',[0.32 0.1 0.64 0.35],'XLim',[0 maxtime]);
                axesup = animatedline('Color','b'); %,'MaximumNumPoints',maxpoints);
                axesdown = animatedline('Color','g');%,'MaximumNumPoints',maxpoints);
                if(dimensionIndex)
                    yyaxis right
                    ylabel('\epsilon (mm/mm)')
                    xlabel('Tiempo (s)')
                    yyaxis left 
                    ylabel('sigma (MPa)')
                    legend({'sigma (MPa)','\epsilon (mm/mm)'},'Location','southwest')
                else
                    yyaxis right
                    ylabel('\Delta x (mm)')
                    xlabel('Tiempo (s)')
                    yyaxis left 
                    ylabel('T (N)')
                    legend({'T(N)','\Delta x (mm)'},'Location','southwest')
                end
                while active
                    input = fread(ser,Ndatos,'int32')';% Datos entrantes
                    
                    if isempty(input)
                        continue;
                    end
                    if( input(1) ~= 255 && input(4) ~= 255)
                        continue;
                    end
                    if(dimensionIndex)
                        deformacion = (input(2)*0.0002)/yDimension;
                        tension = (input(3)-precarga)/(100*yDimension*xDimension);
                    else
                        deformacion = input(2)*0.0002;
                        tension = (input(3)-precarga)/100;
                    end
                    tiempo = tiempo + Ts;
                    addpoints(axesone,deformacion,tension);
                    drawnow;
                    addpoints(axesup,tiempo,deformacion);
                    hold on;
                    addpoints(axesdown,tiempo,tension);
                    drawnow;
                    delta = [delta deformacion];
                    carga = [carga tension];
                    time = [time tiempo];
                end
        end 
    end
    end
        
    function upAndDown(source, eventdata)
            fijar = 0;
            switch source.String
                case 'Arriba'
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,255);
                    fwrite(ser,7);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    %mando a que empiece a mover el motor 
                case 'Abajo'
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,255);
                    fwrite(ser,8);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                case 'Fijar'
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,1);
                    fwrite(ser,255);
                    fwrite(ser,5);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fwrite(ser,0);
                    fijar = 1;
            end
            if (fijar)
                precarga = fread(ser,1,'int32');
                peso = precarga/100;
                loadcellValue.String = string(peso);
            end
    end

    function chooseAnotherRoutine(source, eventdata)
    buttonChooseRoutine.Visible = 'on';
    buttonAdjustSamplePlacement.Visible = 'on';
    traction.Visible = 'on';
    creep.Visible = 'on';
    relaxation.Visible = 'on';
    distraction.Visible = 'on';
    tractionTitle.Visible = 'off';
    creepTitle.Visible = 'off';
    setFrequency.Visible = 'off';
    frequency.Visible = 'off';
    frequencyUnit.Visible = 'off';
    setSpeedTraction.Visible = 'off';
    speed.Visible = 'off';
    load.Visible = 'off';
    setLoad.Visible = 'off';
    buttonChooseAnotherRoutine.Visible = 'off';
    buttonStart.Visible = 'off';
    displacement.Visible = 'off';
    setDisplacement.Visible = 'off';
    relaxationTitle.Visible = 'off';
    maxDisplacementText.Visible = 'off';
    maxDisplacementTraction.Visible = 'off';
    maxDisplacementDistraction.Visible = 'off';
    optionalText.Visible = 'off';
    stress.Visible = 'off';
    setStress.Visible = 'off';
    distractionTitle.Visible = 'off';
    strain.Visible = 'off';
    setStrain.Visible = 'off';
    buttonSave.Visible = 'off';
    strainUnit.Visible = 'off';
    stressUnit.Visible = 'off';
    maxDisplacementUnit.Visible = 'off';
    speedUnit.Visible = 'off';
    loadUnit.Visible = 'off';
    displacementUnit.Visible = 'off';
    stress.Value = 0;
    load.Value = 0;
    displacement.Value = 0;
    strain.Value = 0;
    optionalText2.Visible = 'off';
    cycles.Visible = 'off';
    setCycles.Visible = 'off';
    end

    function adjustSamplePlacement(source, eventdata)
    buttonPlaceSample.Visible = 'on';
    buttonUp.Visible = 'on';
    buttonDown.Visible = 'on';
    buttonSet.Visible = 'on';
    loadcellValue.Visible = 'on';
    loadcellValueUnit.Visible = 'on';
    loadcellText.Visible = 'on';
    end

    function save(source,eventdata)
            [filename, pathname] = uiputfile({'*.csv;','CSV Files (*.csv)'},'Save File','EnsayoBiomecanica');
            if isequal(filename,0) || isequal(pathname,0)
                return
            else
                if strcmp(filename(end-3:end),'.csv')
                    filename = [pathname filename];
                else
                    filename = [pathname filename '.csv'];
                end
                file = array2table([ud.time ud.delta ud.carga]);
                file.Properties.VariableNames(1:3) = {'Tiempo','Deformacion','Carga'};
                writetable(file,filename);
            end
    end
end