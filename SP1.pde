// Globale variabler - disse er tilgængelige i hele programmet
PFont bold;          // Variabel til fed skrift
PFont f;            // Variabel til normal skrift
// Billede variabler til flag - en for hvert land
PImage russia, saudi, egypt, uruguay;
PImage france, australia, peru, denmark;
PImage Portugal, spain, morocco, iran;
PImage argentina, iceland, croatia, nigeria;
PImage danishFlag;  // Variabel til det danske flag billede

// Layout variabler - definerer positioner og størrelser
int x = 50;         // Start x-position for elementer
int w = 440;        // Bredde på hvide baggrundsbokse
int h = 50;         // Højde på bokse
int ySpacing = 60;  // Vertikal afstand mellem rækker
int xSpacing = 460; // Horisontal afstand mellem grupper
int yStart = 70;    // Start y-position for første række
int xColor = 476;   // X-position for farvede markører
int wColor = 15;    // Bredde på farvede markører
int xText = 180;    // X-position for teksten
int yText = 110;    // Y-position for teksten
int groupSpacingY = 280; // Vertikal afstand mellem gruppeblokke 

// Arrays til at gemme flag positioner og hastigheder
float[] flagX = new float[20];  // X-positioner for flagene
float[] flagY = new float[20];  // Y-positioner for flagene
float[] flagSpeedX = new float[20]; // X-hastigheder for flagene
float[] flagSpeedY = new float[20]; // Y-hastigheder for flagene

void setup() {
    size(1000, 600);                    // Sæt vinduestørrelse
    background(7, 29, 59);              // Sæt mørkeblå baggrund
    
    // Tegn en lodret hvid linje i midten af vinduet
    stroke(255);                        // Sæt stregfarve til hvid
    strokeWeight(4);                    // Sæt stregtykkelse
    line(width / 2, 0, width / 2, height);  // Tegn linjen
    
    // Indlæs skrifttyper fra systemet
    bold = loadFont("MicrosoftYaHeiUI-Bold-48.vlw");
    f = loadFont("MicrosoftYaHeiUI-48.vlw");
    
    // Indlæs alle flagbilleder
    loadImages();
    
    // Initialiser positioner og hastigheder for flagene
    for (int i = 0; i < 20; i++) {
        flagX[i] = random(width); // Tilfældig X-position
        flagY[i] = random(height); // Tilfældig Y-position
        flagSpeedX[i] = random(1, 3); // Tilfældig horisontal hastighed
        flagSpeedY[i] = random(1, 3); // Tilfældig vertikal hastighed
    }
    
    // Tegn grupperne med deres respektive data
    drawGroup("GROUP A", 0, 0, color(236, 240, 41),
        new String[]{"RUSSIA", "SAUDI ARABIA", "EGYPT", "URUGUAY"},
        new PImage[]{russia, saudi, egypt, uruguay});
    
    drawGroup("GROUP B", xSpacing, 0, color(236, 240, 41),
        new String[]{"FRANCE", "AUSTRALIA", "PERU", "DENMARK"},
        new PImage[]{france, australia, peru, denmark});
    
    drawGroup("GROUP C", 0, groupSpacingY, color(117, 226, 252),
        new String[]{"PORTUGAL", "SPAIN", "MOROCCO", "IRAN"},
        new PImage[]{Portugal, spain, morocco, iran});
    
    drawGroup("GROUP D", xSpacing, groupSpacingY, color(117, 226, 252),
        new String[]{"ARGENTINA", "ICELAND", "CROATIA", "NIGERIA"},
        new PImage[]{argentina, iceland, croatia, nigeria});
}

void loadImages() {
    // Indlæs billeder for landenes flag
    russia = loadImage("russia.png");
    saudi = loadImage("saudi.png");
    egypt = loadImage("egypt.png");
    uruguay = loadImage("uruguay.png");
    france = loadImage("france.png");
    australia = loadImage("australia.png");
    peru = loadImage("peru.png");
    denmark = loadImage("denmark.png");
    Portugal = loadImage("portugal.png");
    spain = loadImage("spain.png");
    morocco = loadImage("morocco.png");
    iran = loadImage("iran.png");
    argentina = loadImage("argentina.png");
    iceland = loadImage("iceland.png");
    croatia = loadImage("croatia.png");
    nigeria = loadImage("nigeria.png");
    
    // Indlæs det danske flag
    danishFlag = loadImage("denmark.png");
}

void draw() {
    // Opdater positionerne af flagene
    for (int i = 0; i < 20; i++) {
        flagX[i] += flagSpeedX[i];
        flagY[i] += flagSpeedY[i];
        
        // Flagene skal hoppe tilbage, når de rammer vinduets kanter
        if (flagX[i] > width || flagX[i] < 0) {
            flagSpeedX[i] *= -1; // Vend retningen på X-aksen
        }
        if (flagY[i] > height || flagY[i] < 0) {
            flagSpeedY[i] *= -1; // Vend retningen på Y-aksen
        }
        
        // Tegn flaget på den nye position
        image(danishFlag, flagX[i], flagY[i]);
    }
    
    // Tegn resten af indholdet
    drawGroup("GROUP A", 0, 0, color(236, 240, 41),
        new String[]{"RUSSIA", "SAUDI ARABIA", "EGYPT", "URUGUAY"},
        new PImage[]{russia, saudi, egypt, uruguay});
    
    drawGroup("GROUP B", xSpacing, 0, color(236, 240, 41),
        new String[]{"FRANCE", "AUSTRALIA", "PERU", "DENMARK"},
        new PImage[]{france, australia, peru, denmark});
    
    drawGroup("GROUP C", 0, groupSpacingY, color(117, 226, 252),
        new String[]{"PORTUGAL", "SPAIN", "MOROCCO", "IRAN"},
        new PImage[]{Portugal, spain, morocco, iran});
    
    drawGroup("GROUP D", xSpacing, groupSpacingY, color(117, 226, 252),
        new String[]{"ARGENTINA", "ICELAND", "CROATIA", "NIGERIA"},
        new PImage[]{argentina, iceland, croatia, nigeria});
}

// Funktion til at tegne en gruppe med lande
void drawGroup(String groupName, int xOffset, int yOffset, color groupColor, 
               String[] countries, PImage[] flags) {
    // Tegn gruppeoverskrift med den angivne farve
    fill(groupColor);
    textFont(bold);
    textSize(30);
    text(groupName, 210 + xOffset, 60 + yOffset);
    
    // Tegn hver række i gruppen
    for (int i = 0; i < countries.length; i++) {
        int yPos = yStart + (i * ySpacing) + yOffset;
        
        // Tegn en hvid baggrundsboks
        noStroke();
        fill(255);
        rect(x + xOffset, yPos, w, h);
        
        // Tegn farvet markør på siden
        fill(groupColor);
        rect(xColor + xOffset, yPos, wColor, h);
        
        // Tegn flaget
        image(flags[i], x + xOffset, yPos);
        
        // Skriv landets navn
        fill(7, 29, 59);  // Mørkeblå tekstfarve
        textFont(f);
        textSize(30);
        text(countries[i], xText + xOffset, yPos + 35);
    }
}
