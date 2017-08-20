#include <a_samp>
#include <streamer>
#include <zcmd>
#include <foreach>
#include <sscanf2>
#include <YSI\y_ini>
forward MyTimer(playerid);
#define SCM SendClientMessage
#define sit strval(inputtext)
#define pCar idvozila[PlayerInfo[playerid][Car1ID]]
#define PCID PlayerInfo[playerid][Car1ID]
#define zovemID GetPVarInt(playerid, "zovem_id")
#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#pragma tabsize 0
/*
IDOVI POSLOVA
TODO: 0 - Prodavnica
TODO: 1 - marketing agencija
TODO: 2 - fast food
TODO: 3 - bar
TODO: 4 - restoran
TODO: 5 - Banka
TODO: 6 - Weapon shop
TODO: 8 - Skin shop
TODO: 9 - Nocni klub
TODO: 10 - Music shop
TODO: 11 - Sex shop
*/
new Float:svx[MAX_PLAYERS]; // Sprema brzinu X
new Float:svy[MAX_PLAYERS]; // Sprema brzinu Y
new Float:svz[MAX_PLAYERS]; // Sprema brzinu Z
new Float:o1[MAX_PLAYERS]; // Rezultat formule
new o2[MAX_PLAYERS]; // Rezultat formule zaokruzen
new o3[MAX_PLAYERS][256]; // Ovo se prikazuje igracu
new speedtimer[MAX_PLAYERS];

//===============[ VOZILA ]===================================================||
new tmpobjid;

new callchat[MAX_PLAYERS];
new realchat[MAX_PLAYERS];
new cArmy[14];
new eleVeh[8];
new mail[8];
new rudar[6];
new milk[6];
new farm[15];
new zito[22];
new drvo[11][MAX_PLAYERS];
new drogaObject[10];

new posijano;
new zauzeto;

new zkrava1;
new zkrava2;
new zkrava3;
// PICKUPOVI
new PickupBiznisProdano[100];
new PickupBiznisNeprodano[100];
new Text3D:TextDrogaTaken[11];
new Text3D:TextDrogaUntaken[11];
new PickupDrogaUntaken[11];


#define MAX_SALON 10
new Text3D:v3D[MAX_VEHICLES];
new Text3D:as3D[8];
new idvozila[MAX_VEHICLES];
new asCar[MAX_SALON];
new as3Dadd[8];

new PickupNeprodano[100];
new KucaPickupDa[100];
new KucaPickupNe[100];
//new PickupProdano;
////////////////////////////////////////////////////////////////////////////////

forward speedometer(playerid); // This Forwards The Timer To Our Function
/* Server Colors */
#define COLOR_PURPLE    0xC2A2DAAA
#define COLOR_GRAD2  	0xBFC0C2FF
#define COLOR_GRAD1 	0xB4B5B7FF
#define COLOR_GRAD2 	0xBFC0C2FF
#define COLOR_GREY 		0xAFAFAFAA
#define COLOR_GRAD3 	0xCBCCCEFF
#define COLOR_LIGHTBLUE 0x006FDD96
#define COLOR_GRAD4 	0xD8D8D8FF
#define COLOR_FADE 		0xC8C8C8C8
#define COLOR_FADE2 	0xC8C8C8C8
#define COLOR_FADE3 	0xAAAAAAAA
#define COLOR_FADE4 	0x8C8C8C8C
#define COLOR_RED		 0xFF0000FF
//#define COLOR_YELLOW 	0xDABB3E00
#define COLOR_YELLOW	0xFFE60000
#define COLOR_FADE5 	0x6E6E6E6E
#define COLOR_GRAD5 	0xE3E3E3FF
#define COLOR_FADE1 	0xE6E6E6E6
#define COLOR_GRAD6 	0xF0F0F0FF
#define COLOR_ORANGE    0xE86800FF
#define COLOR_ORGCHAT		0xD4B390FF
#define COLOR_LCHAT			0x00FFFFFF
#define houseboja       "{00C100}"
#define TEAM_HIT_COLOR 	0xFFFFFF00
#define ADMINWARN       0xFF0033FF
#define COLOR_WHITE			0xFFFFFFFF

#define STRING_RED      "{ff0000}"
#define STRING_PD       "{ff6600}"
#define STRING_GRAY    	"{cccccc}"
#define STRING_GREEN    "{00FF00}"
#define STRING_ADMWARN  "{F64F4F}"
#define STRING_WHITE    "{ffffff}"
#define STRING_LJUBIC   "{ff0099}"
#define STRING_YELLOW   "{ffe600}"

#define bijela          "{00C100}"
#define ZUTA            "{F3FF02}"
#define COLOR_GREEN		0x00FF00FF
#define COLOR_REPORT	0x196236FF

#define COLOR_ADMWARN 	0xF64F4FAA

#define BOJA_NARANCASTA 0xFF7700AA
#define COLOR_ONDUTY 0xFDB00D8AA
#define COLOR_LIGHTGREEN 0x00FF00FF
#define COLOR_PINK 0xC2A2DAAA
#define COLOR_SVJETLOPLAVA 0x00EEFFAA
#define COLOR_DGOLD 0xFFDD66AA
#define TEAM_GROVE_COLOR 0x00D900C8
//=======[ BIZNIS LABELI ]=====================================================|
new Text3D:nekupljena;
new Text3D:kupljena;

new Text3D:TextProdano[100];
new Text3D:TextNeprodano[100];

new Text3D:KucaLabelDa[100];
new Text3D:KucaLabelNe[100];
//==============================================================================
new Text:SkinTD0;
new Text:SkinTD1;
new Text:SkinTD2;
new Text:SkinTD3;
new Text:SkinTD4;
new Text:SkinTD5;
new Text:SkinTD6;
new Text:SkinTD7;
new Text:SkinTD8;
new Text:SkinTD9;
new Text:SkinTD10;
new Text:SkinTD11;
new Text:SkinTD12;
new Text:SkinTD13;
new Text:SkinTD14;
new Text:SkinTD15;
//==============================
new Text:stats0[MAX_PLAYERS];
new Text:stats1[MAX_PLAYERS];
new Text:stats2[MAX_PLAYERS];
new Text:stats3[MAX_PLAYERS];
new Text:stats4[MAX_PLAYERS];
new Text:stats5[MAX_PLAYERS];
new Text:stats6[MAX_PLAYERS];
new Text:stats7[MAX_PLAYERS];
new Text:stats8[MAX_PLAYERS];
new Text:stats9[MAX_PLAYERS];
new Text:stats10[MAX_PLAYERS];
new Text:stats11[MAX_PLAYERS];
new Text:stats12[MAX_PLAYERS];
new Text:stats13[MAX_PLAYERS];
new Text:stats14[MAX_PLAYERS];
new Text:stats15[MAX_PLAYERS];
new Text:stats16[MAX_PLAYERS];
new Text:stats17[MAX_PLAYERS];
new Text:stats18[MAX_PLAYERS];
new Text:stats19[MAX_PLAYERS];
new Text:stats20[MAX_PLAYERS];
new Text:stats21[MAX_PLAYERS];
new Text:stats22[MAX_PLAYERS];
new Text:stats23[MAX_PLAYERS];
new Text:stats24[MAX_PLAYERS];
new Text:stats25[MAX_PLAYERS];
new Text:stats26[MAX_PLAYERS];
new Text:stats27[MAX_PLAYERS];
new Text:stats28[MAX_PLAYERS];
new Text:stats29[MAX_PLAYERS];
new Text:stats30[MAX_PLAYERS];
new Text:stats31[MAX_PLAYERS];
new Text:stats32[MAX_PLAYERS];
//==============================================================================
new Text:speedbar0;
new Text:speedbar1;
new Text:speedbar2;
new Text:speedbar3;
new Text:speedbar4;

new PlayerText:speedbar5[MAX_PLAYERS];
new PlayerText:speedbar6[MAX_PLAYERS];
new PlayerText:speedbar7[MAX_PLAYERS];
new PlayerText:speedbar8[MAX_PLAYERS];

new PlayerText:AreaJailTD0[MAX_PLAYERS];
//=============================================================================| Definovi
#define PATH "Accounts/%s.ini"
#define KucaPath "Kuce/%i.ini"
#define BiznisPath "Biznisi/%i.ini"
#define VehiclePath "Vehicle/%i.ini"
#define DrogaPath "Droga/%i.ini"
#define SECONDS(%1) ((%1)*(1000))
#define ALTCOMMAND:%1->%2;           \
COMMAND:%1(playerid, params[])   \
return cmd_%2(playerid, params);
#define function%0(%1) forward%0(%1); public%0(%1)
#define MAX_HOUSE 50 //Maksimalan broj kuca
#define BROJ_KUCA 100
#define MAX_VEHICLE 500
#define MAX_DROGA 10

#define MAX_BUSINESS 100
#define VEH_FILE "Auta/auta.ini" //Definira putanju za spremanje auta

/* SERVER SIDE CASH */
#define GivePlayerCash(%0,%1) SetPVarInt(%0,"Money",GetPlayerCash(%0)+%1),GivePlayerMoney(%0,%1)
#define ResetPlayerCash(%0) SetPVarInt(%0,"Money",0), ResetPlayerMoney(%0)
#define GetPlayerCash(%0) GetPVarInt(%0,"Money")

/* DIALOGS */
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define	DIALOG_AGE 3
#define DIALOG_SEX 4
#define DIALOG_KUPI 5
#define DIALOG_KUPI_TRG 6

#define DIALOG_HWITHDRAW 7
#define DIALOG_HDEPOSIT 8

#define DIALOG_SELL1 9
#define DIALOG_SELL2 10
#define DIALOG_PRIHVATI 11

#define DIALOG_OGLAS 12

#define DIALOG_FASTFOOD 13
#define DIALOG_DRINK 14
#define DIALOG_RESTORAN 15
#define DIALOG_BANKA 16
#define DIALOG_BANKA2 17
#define DIALOG_BANKA3 18
#define DIALOG_BANKA4 19
#define DIALOG_BANKA5 20

#define DIALOG_BIZNIS1 21
#define DIALOG_BIZNIS2 22
#define DIALOG_BIZNIS3 23
#define DIALOG_BIZNIS4 24
#define DIALOG_BIZNIS5 25

#define DIALOG_WEAPON 26
#define DIALOG_NIGHTCLUB 27
#define DIALOG_AUTOSALON 28
#define DIALOG_VEHICLE 29
#define DIALOG_VEHBOJA1 30
#define DIALOG_VEHBOJA2 31
#define DIALOG_VEHPRODAJ1 32
#define DIALOG_VEHPRODAJ2 33
#define DIALOG_VEHPONUDA 34
#define DIALOG_INVITE 35
#define DIALOG_INVITE_PONUDA 36
#define DIALOG_ORG_KICK 37
#define DIALOG_ORG_RANK 38
#define DIALOG_ORG_DERANK 39
#define DIALOG_FARM 40
#define DIALOG_ID_REZOLUCIJA 41
#define DIALOG_BLACKMARKET 42
#define DIALOG_KUPIDROGU 43
#define DIALOG_PRODAJDROGU 44
#define DIALOG_SJEME 45
#define DIALOG_DRVOSJECA 46
#define DIALOG_ATELEPORT 47
#define DIALOG_ATELEPORT_ORG 48
#define DIALOG_ATELEPORT_JOB 49
#define DIALOG_OBRADA 50

/* ENUMS */
enum Droga{
	dID,
	dVlasnik[MAX_PLAYER_NAME],
	dPlanted,
	dGrown,
	dZauzeto,
	dMinuta,
	Float:dPosX,
	Float:dPosY,
	Float:dPosZ
}
enum Vehicle
{
	vID,
	vVlasnik[MAX_PLAYER_NAME],
	vTip,
	vLocked,
	Kupljen,
	vFuel,
	vColor1,
	vColor2,
	vLight,
	vKupljen,
	Float:vPosX,
	Float:vPosY,
	Float:vPosZ,
	Float:vParkX,
	Float:vParkY,
	Float:vParkZ,
	Float:vAngle
}
enum Biznis
{
	bID,
	bVlasnik[MAX_PLAYER_NAME],
	bCijena,
	bTip,
	bProdano,
	Float:bUlazX,
	Float:bUlazY,
	Float:bUlazZ,
	bMoney
}
enum Kuca
{
	kID,
	kVlasnik[MAX_PLAYER_NAME],
	kCijena,
	kVelicina,
	kLocked,
	kOruzje,
	kProdano,
	Float:kUlazX,
	Float:kUlazY,
	Float:kUlazZ,
	kMoney,
	kAmmo
}
//=============================================================================
new KucaInfo[MAX_HOUSE][Kuca];
new BiznisInfo[MAX_BUSINESS][Biznis];
new VehicleInfo[MAX_VEHICLE][Vehicle];
new DrogaInfo[MAX_DROGA][Droga];
forward UcitajVehicleInfo(ips,name[],value[]);
public UcitajVehicleInfo(ips,name[],value[])
{
	INI_Int("ID",VehicleInfo[ips][vID]);
	INI_Int("Vrsta",VehicleInfo[ips][vTip]);
	INI_Int("Boja1",VehicleInfo[ips][vColor1]);
	INI_Int("Boja2",VehicleInfo[ips][vColor2]);
	INI_Int("Kupljen",VehicleInfo[ips][vKupljen]);
	INI_Int("lights",VehicleInfo[ips][vLight]);
	INI_Float("ParkX",VehicleInfo[ips][vParkX]);
	INI_Float("ParkY",VehicleInfo[ips][vParkY]);
	INI_Float("ParkZ",VehicleInfo[ips][vParkZ]);
	INI_Float("Angle",VehicleInfo[ips][vAngle]);
	INI_Float("PosX",VehicleInfo[ips][vPosX]);
	INI_Float("PosY",VehicleInfo[ips][vPosY]);
	INI_Float("PosZ",VehicleInfo[ips][vPosZ]);
	INI_String("Vlasnik",VehicleInfo[ips][vVlasnik], 24);
	INI_Int("Gorivo",VehicleInfo[ips][vFuel]);
	INI_Int("Locked",VehicleInfo[ips][vLocked]);
	return 1;
}
forward UcitajDrogaInfo(ipd, name[],value[]);
public UcitajDrogaInfo(ipd, name[],value[])
{
	INI_Int("ID", DrogaInfo[ipd][dID]);
	INI_String("Vlasnik",DrogaInfo[ipd][dVlasnik], 24);
	INI_Int("Posadjeno", DrogaInfo[ipd][dPlanted]);
	INI_Int("Minuta", DrogaInfo[ipd][dMinuta]);
	INI_Int("Naraslo", DrogaInfo[ipd][dGrown]);
	INI_Int("Zauzeto", DrogaInfo[ipd][dZauzeto]);
	INI_Float("X",DrogaInfo[ipd][dPosX]);
	INI_Float("Y",DrogaInfo[ipd][dPosY]);
	INI_Float("Z",DrogaInfo[ipd][dPosZ]);
	return 1;
}
forward UcitajBiznisInfo(ipy,name[],value[]);
public UcitajBiznisInfo(ipy,name[],value[])
{
	INI_Int("ID",BiznisInfo[ipy][bID]);
	INI_Int("Cijena",BiznisInfo[ipy][bCijena]);
	INI_Float("UlazX",BiznisInfo[ipy][bUlazX]);
	INI_Float("UlazY",BiznisInfo[ipy][bUlazY]);
	INI_Float("UlazZ",BiznisInfo[ipy][bUlazZ]);
	INI_String("Vlasnik",BiznisInfo[ipy][bVlasnik], 24);
	INI_Int("Tip",BiznisInfo[ipy][bTip]);
	INI_Int("Prodano",BiznisInfo[ipy][bProdano]);
	INI_Int("Blagajna",BiznisInfo[ipy][bMoney]);
	return 1;
}
forward UcitajKucaInfo(ipx,name[],value[]);
public UcitajKucaInfo(ipx,name[],value[])
{
	INI_Int("ID",KucaInfo[ipx][kID]);
	INI_Int("Cijena",KucaInfo[ipx][kCijena]);
	INI_Int("Oruzje",KucaInfo[ipx][kOruzje]);
	INI_Float("UlazX",KucaInfo[ipx][kUlazX]);
	INI_Float("UlazY",KucaInfo[ipx][kUlazY]);
	INI_Float("UlazZ",KucaInfo[ipx][kUlazZ]);
	INI_Int("Prodano",KucaInfo[ipx][kProdano]);
	INI_Int("Locked",KucaInfo[ipx][kLocked]);
	INI_String("Vlasnik",KucaInfo[ipx][kVlasnik], 24);
	INI_Int("Velicina",KucaInfo[ipx][kVelicina]);
	INI_Int("Novac",KucaInfo[ipx][kMoney]);
	INI_Int("Ammo",KucaInfo[ipx][kAmmo]);
	return 1;
}
enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pSex,
    pAge,
   	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pSkin,
	pTeam,
	pAccent,
	KucaID,
	pHrana,
	BiznisID,
	pLevel,
	pRespekt,
	pDoRespekta,
	pOruzje,
	pLetenje,
	pKazne,
	pOrg,
	pRank,
	OrgSati,
	OrgDostave,
	pJob,
	JobSkill,
	JobUgovor,
	JobPlaca,
	Car1ID,
	Car2ID,
	DrogaID,
	pCigarete,
	pKredit,
	pOCN,
	pBanka,
	pDuty,
	pVoda,
	pPlaca,
	pSjeme,
	pDroga,
	pNovaDroga,
	pMob,
	pArea,
	pAreaMin,
	pAreaSec,
	Float:pSpawnX,
	Float:pSpawnY,
	Float:pSpawnZ
}
new PlayerInfo[MAX_PLAYERS][pInfo];
/* <--------------------------------------------> */

main()
{
    print(" ");
    print(" ");
    print("- Vintage Republic RPG UCITAN -");
    print(" ");
    print(" Script: Speachless");
}
//------------ New ----------------------------------------------------------//
new Text:Welcome0;
new Text:Welcome1;
new Text:Welcome2;
new Text:Welcome3;
new Text:Welcome4;
new Text:Welcome5;
new Text:Welcome6;
new Text:Welcome7;
new Text:Welcome8;
new Text:Welcome9;
new Text:Welcome10;
new Text:Welcome11;
new Text:Welcome12;
new Text:Welcome13;
new Text:Welcome14;
new Text:Welcome15;
//------------------------------------------------------------------------------
new Text:tdbar0;
new Text:tdbar1;
new Text:tdbar2;
new Text:tdbar3;
new Text:tdbar4;

new PlayerText:tdbar5[MAX_PLAYERS];
new PlayerText:tdbar6[MAX_PLAYERS];


//------------------------------------------------------------------------------| Speedometer



//------------------------------------------------------------------------------
new Logged[MAX_PLAYERS], gOoc[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
drvo[1][playerid] = CreateDynamicObject(617,-516.2989500,-39.0808100,59.7000500,0.0000000,0.0000000,0.0000000); //
drvo[2][playerid] = CreateDynamicObject(617,-493.2420300,-63.4167800,58.9565200,0.0000000,0.0000000,0.0000000); //
drvo[3][playerid] = CreateDynamicObject(617,-475.9665500,-54.4567400,58.8342700,0.0000000,0.0000000,0.0000000); //
drvo[4][playerid] = CreateDynamicObject(617,-462.4106800,-42.0669900,58.5198200,0.0000000,0.0000000,0.0000000); //
drvo[5][playerid] = CreateDynamicObject(617,-458.8218700,-72.1493900,57.2541200,0.0000000,0.0000000,0.0000000); //
drvo[6][playerid] = CreateDynamicObject(617,-540.2927900,-23.7134700,59.7000500,0.0000000,0.0000000,0.0000000); //
drvo[7][playerid] = CreateDynamicObject(617,-551.5644500,-41.0374000,61.9227700,0.0000000,0.0000000,0.0000000); //
drvo[8][playerid] = CreateDynamicObject(617,-521.5442500,-72.9805200,61.0320200,0.0000000,0.0000000,-1.2000000); //
drvo[9][playerid] = CreateDynamicObject(617,-450.7583000,-94.7827500,58.0418100,0.0000000,0.0000000,0.0000000); //
drvo[10][playerid] = CreateDynamicObject(617,-469.7067900,-93.5273700,58.0418100,0.0000000,0.0000000,0.0000000); //
//---------------------
SetPVarInt(playerid, "Gun", 0);
callchat[playerid] = 0;
realchat[playerid] = 1;
//-----------------------------------------------------------------------------
tdbar5[playerid] = CreatePlayerTextDraw(playerid, 14.524154, 394.333435, "----------");
PlayerTextDrawLetterSize(playerid, tdbar5[playerid], 0.190907, 4.855000);
PlayerTextDrawAlignment(playerid, tdbar5[playerid], 1);
PlayerTextDrawColor(playerid, tdbar5[playerid], -1);
PlayerTextDrawSetShadow(playerid, tdbar5[playerid], 0);
PlayerTextDrawSetOutline(playerid, tdbar5[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, tdbar5[playerid], 51);
PlayerTextDrawFont(playerid, tdbar5[playerid], 1);
PlayerTextDrawSetProportional(playerid, tdbar5[playerid], 1);

tdbar6[playerid] = CreatePlayerTextDraw(playerid, 14.524145, 380.916625, "----------");
PlayerTextDrawLetterSize(playerid, tdbar6[playerid], 0.193250, 5.152500);
PlayerTextDrawAlignment(playerid, tdbar6[playerid], 1);
PlayerTextDrawColor(playerid, tdbar6[playerid], -1);
PlayerTextDrawSetShadow(playerid, tdbar6[playerid], 0);
PlayerTextDrawSetOutline(playerid, tdbar6[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, tdbar6[playerid], 51);
PlayerTextDrawFont(playerid, tdbar6[playerid], 1);
PlayerTextDrawSetProportional(playerid, tdbar6[playerid], 1);
//______________________________________________________________________________
AreaJailTD0[playerid] = CreatePlayerTextDraw(playerid, 316.000061, 404.693603, "Area: 300min i 60s");
PlayerTextDrawLetterSize(playerid, AreaJailTD0[playerid], 0.314799, 3.182933);
PlayerTextDrawAlignment(playerid, AreaJailTD0[playerid], 2);
PlayerTextDrawColor(playerid, AreaJailTD0[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, AreaJailTD0[playerid], 0);
PlayerTextDrawSetOutline(playerid, AreaJailTD0[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, AreaJailTD0[playerid], 51);
PlayerTextDrawFont(playerid, AreaJailTD0[playerid], 1);
PlayerTextDrawSetProportional(playerid, AreaJailTD0[playerid], 1);
//______________________________________________________________________________

speedbar5[playerid] = CreatePlayerTextDraw(playerid, 527.086242, 387.333160, "300");
PlayerTextDrawLetterSize(playerid, speedbar5[playerid], 0.368476, 2.043334);
PlayerTextDrawAlignment(playerid, speedbar5[playerid], 2);
PlayerTextDrawColor(playerid, speedbar5[playerid], -1);
PlayerTextDrawSetShadow(playerid, speedbar5[playerid], 0);
PlayerTextDrawSetOutline(playerid, speedbar5[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, speedbar5[playerid], 51);
PlayerTextDrawFont(playerid, speedbar5[playerid], 3);
PlayerTextDrawSetProportional(playerid, speedbar5[playerid], 1);

speedbar6[playerid] = CreatePlayerTextDraw(playerid, 558.008850, 369.833221, "Sultan");
PlayerTextDrawLetterSize(playerid, speedbar6[playerid], 0.344581, 1.920833);
PlayerTextDrawAlignment(playerid, speedbar6[playerid], 1);
PlayerTextDrawColor(playerid, speedbar6[playerid], -5963521);
PlayerTextDrawSetShadow(playerid, speedbar6[playerid], 0);
PlayerTextDrawSetOutline(playerid, speedbar6[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, speedbar6[playerid], 51);
PlayerTextDrawFont(playerid, speedbar6[playerid], 2);
PlayerTextDrawSetProportional(playerid, speedbar6[playerid], 1);

speedbar7[playerid] = CreatePlayerTextDraw(playerid, 570.659179, 389.666717, "Fuel: 50L");
PlayerTextDrawLetterSize(playerid, speedbar7[playerid], 0.253688, 1.926666);
PlayerTextDrawAlignment(playerid, speedbar7[playerid], 1);
PlayerTextDrawColor(playerid, speedbar7[playerid], -1);
PlayerTextDrawSetShadow(playerid, speedbar7[playerid], 0);
PlayerTextDrawSetOutline(playerid, speedbar7[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, speedbar7[playerid], 51);
PlayerTextDrawFont(playerid, speedbar7[playerid], 2);
PlayerTextDrawSetProportional(playerid, speedbar7[playerid], 1);

speedbar8[playerid] = CreatePlayerTextDraw(playerid, 571.127380, 407.166687, "100%");
PlayerTextDrawLetterSize(playerid, speedbar8[playerid], 0.512781, 2.148334);
PlayerTextDrawAlignment(playerid, speedbar8[playerid], 1);
PlayerTextDrawColor(playerid, speedbar8[playerid], -1);
PlayerTextDrawSetShadow(playerid, speedbar8[playerid], 0);
PlayerTextDrawSetOutline(playerid, speedbar8[playerid], 1);
PlayerTextDrawBackgroundColor(playerid, speedbar8[playerid], 51);
PlayerTextDrawFont(playerid, speedbar8[playerid], 2);
PlayerTextDrawSetProportional(playerid, speedbar8[playerid], 1);
//______________________________________________________________________________

stats0[playerid] = TextDrawCreate(179.101013, 160.166641, "usebox");
TextDrawLetterSize(stats0[playerid], 0.000000, 18.414815);
TextDrawTextSize(stats0[playerid], 456.682281, 0.000000);
TextDrawAlignment(stats0[playerid], 1);
TextDrawColor(stats0[playerid], 0);
TextDrawUseBox(stats0[playerid], true);
TextDrawBoxColor(stats0[playerid], 102);
TextDrawSetShadow(stats0[playerid], 0);
TextDrawSetOutline(stats0[playerid], 0);
TextDrawFont(stats0[playerid], 0);

stats1[playerid] = TextDrawCreate(179.101013, 159.583343, "usebox");
TextDrawLetterSize(stats1[playerid], 0.000000, 18.479629);
TextDrawTextSize(stats1[playerid], 176.506591, 0.000000);
TextDrawAlignment(stats1[playerid], 1);
TextDrawColor(stats1[playerid], 0);
TextDrawUseBox(stats1[playerid], true);
TextDrawBoxColor(stats1[playerid], -5963521);
TextDrawSetShadow(stats1[playerid], 0);
TextDrawSetOutline(stats1[playerid], 0);
TextDrawFont(stats1[playerid], 0);

stats2[playerid] = TextDrawCreate(460.213775, 159.583328, "usebox");
TextDrawLetterSize(stats2[playerid], 0.000000, 18.479631);
TextDrawTextSize(stats2[playerid], 455.745239, 0.000000);
TextDrawAlignment(stats2[playerid], 1);
TextDrawColor(stats2[playerid], 0);
TextDrawUseBox(stats2[playerid], true);
TextDrawBoxColor(stats2[playerid], -5963521);
TextDrawSetShadow(stats2[playerid], 0);
TextDrawSetOutline(stats2[playerid], 0);
TextDrawFont(stats2[playerid], 0);

stats3[playerid] = TextDrawCreate(185.066055, 131.833374, "Mark_Blueberry");
TextDrawLetterSize(stats3[playerid], 0.281798, 2.883336);
TextDrawAlignment(stats3[playerid], 1);
TextDrawColor(stats3[playerid], -1);
TextDrawSetShadow(stats3[playerid], 0);
TextDrawSetOutline(stats3[playerid], 1);
TextDrawBackgroundColor(stats3[playerid], 51);
TextDrawFont(stats3[playerid], 2);
TextDrawSetProportional(stats3[playerid], 1);

stats4[playerid] = TextDrawCreate(186.002914, 178.500045, "OPCENITO");
TextDrawLetterSize(stats4[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats4[playerid], 1);
TextDrawColor(stats4[playerid], -5963521);
TextDrawSetShadow(stats4[playerid], 0);
TextDrawSetOutline(stats4[playerid], 1);
TextDrawBackgroundColor(stats4[playerid], 51);
TextDrawFont(stats4[playerid], 1);
TextDrawSetProportional(stats4[playerid], 1);

stats5[playerid] = TextDrawCreate(186.939971, 191.333282, "Level: 23");
TextDrawLetterSize(stats5[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats5[playerid], 1);
TextDrawColor(stats5[playerid], -1);
TextDrawSetShadow(stats5[playerid], 0);
TextDrawSetOutline(stats5[playerid], 1);
TextDrawBackgroundColor(stats5[playerid], 51);
TextDrawFont(stats5[playerid], 1);
TextDrawSetProportional(stats5[playerid], 1);

stats6[playerid] = TextDrawCreate(186.939987, 200.666671, "Respekt: 3/14");
TextDrawLetterSize(stats6[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats6[playerid], 1);
TextDrawColor(stats6[playerid], -1);
TextDrawSetShadow(stats6[playerid], 0);
TextDrawSetOutline(stats6[playerid], 1);
TextDrawBackgroundColor(stats6[playerid], 51);
TextDrawFont(stats6[playerid], 1);
TextDrawSetProportional(stats6[playerid], 1);

stats7[playerid] = TextDrawCreate(186.939926, 210.583374, "Do respekta: 20/60");
TextDrawLetterSize(stats7[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats7[playerid], 1);
TextDrawColor(stats7[playerid], -1);
TextDrawSetShadow(stats7[playerid], 0);
TextDrawSetOutline(stats7[playerid], 1);
TextDrawBackgroundColor(stats7[playerid], 51);
TextDrawFont(stats7[playerid], 1);
TextDrawSetProportional(stats7[playerid], 1);

stats8[playerid] = TextDrawCreate(187.408477, 220.500000, "Novac: $2500");
TextDrawLetterSize(stats8[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats8[playerid], 1);
TextDrawColor(stats8[playerid], -1);
TextDrawSetShadow(stats8[playerid], 0);
TextDrawSetOutline(stats8[playerid], 1);
TextDrawBackgroundColor(stats8[playerid], 51);
TextDrawFont(stats8[playerid], 1);
TextDrawSetProportional(stats8[playerid], 1);

stats9[playerid] = TextDrawCreate(187.408493, 231.000000, "Banka: 2500000$");
TextDrawLetterSize(stats9[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats9[playerid], 1);
TextDrawColor(stats9[playerid], -1);
TextDrawSetShadow(stats9[playerid], 0);
TextDrawSetOutline(stats9[playerid], 1);
TextDrawBackgroundColor(stats9[playerid], 51);
TextDrawFont(stats9[playerid], 1);
TextDrawSetProportional(stats9[playerid], 1);

stats10[playerid] = TextDrawCreate(187.408508, 241.500045, "Dozv. oruzje: 100h");
TextDrawLetterSize(stats10[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats10[playerid], 1);
TextDrawColor(stats10[playerid], -1);
TextDrawSetShadow(stats10[playerid], 0);
TextDrawSetOutline(stats10[playerid], 1);
TextDrawBackgroundColor(stats10[playerid], 51);
TextDrawFont(stats10[playerid], 1);
TextDrawSetProportional(stats10[playerid], 1);

stats11[playerid] = TextDrawCreate(187.408508, 251.416625, "Dozv. letenje: 100h");
TextDrawLetterSize(stats11[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats11[playerid], 1);
TextDrawColor(stats11[playerid], -1);
TextDrawSetShadow(stats11[playerid], 0);
TextDrawSetOutline(stats11[playerid], 1);
TextDrawBackgroundColor(stats11[playerid], 51);
TextDrawFont(stats11[playerid], 1);
TextDrawSetProportional(stats11[playerid], 1);

stats12[playerid] = TextDrawCreate(187.408508, 260.166656, "Kazne: 0");
TextDrawLetterSize(stats12[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats12[playerid], 1);
TextDrawColor(stats12[playerid], -1);
TextDrawSetShadow(stats12[playerid], 0);
TextDrawSetOutline(stats12[playerid], 1);
TextDrawBackgroundColor(stats12[playerid], 51);
TextDrawFont(stats12[playerid], 1);
TextDrawSetProportional(stats12[playerid], 1);

stats13[playerid] = TextDrawCreate(284.860809, 178.499938, "ORGANIZACIJA");
TextDrawLetterSize(stats13[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats13[playerid], 1);
TextDrawColor(stats13[playerid], -5963521);
TextDrawSetShadow(stats13[playerid], 0);
TextDrawSetOutline(stats13[playerid], 1);
TextDrawBackgroundColor(stats13[playerid], 51);
TextDrawFont(stats13[playerid], 1);
TextDrawSetProportional(stats13[playerid], 1);

stats14[playerid] = TextDrawCreate(284.861053, 191.333297, "Org: Carson Army");
TextDrawLetterSize(stats14[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats14[playerid], 1);
TextDrawColor(stats14[playerid], -1);
TextDrawSetShadow(stats14[playerid], 0);
TextDrawSetOutline(stats14[playerid], 1);
TextDrawBackgroundColor(stats14[playerid], 51);
TextDrawFont(stats14[playerid], 1);
TextDrawSetProportional(stats14[playerid], 1);

stats15[playerid] = TextDrawCreate(285.329528, 201.250000, "Rank: Cadet");
TextDrawLetterSize(stats15[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats15[playerid], 1);
TextDrawColor(stats15[playerid], -1);
TextDrawSetShadow(stats15[playerid], 0);
TextDrawSetOutline(stats15[playerid], 1);
TextDrawBackgroundColor(stats15[playerid], 51);
TextDrawFont(stats15[playerid], 1);
TextDrawSetProportional(stats15[playerid], 1);

stats16[playerid] = TextDrawCreate(285.798095, 211.166687, "Provedeno sati: 0");
TextDrawLetterSize(stats16[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats16[playerid], 1);
TextDrawColor(stats16[playerid], -1);
TextDrawSetShadow(stats16[playerid], 0);
TextDrawSetOutline(stats16[playerid], 1);
TextDrawBackgroundColor(stats16[playerid], 51);
TextDrawFont(stats16[playerid], 1);
TextDrawSetProportional(stats16[playerid], 1);

stats17[playerid] = TextDrawCreate(285.797851, 221.083358, "Dostave: 0");
TextDrawLetterSize(stats17[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats17[playerid], 1);
TextDrawColor(stats17[playerid], -1);
TextDrawSetShadow(stats17[playerid], 0);
TextDrawSetOutline(stats17[playerid], 1);
TextDrawBackgroundColor(stats17[playerid], 51);
TextDrawFont(stats17[playerid], 1);
TextDrawSetProportional(stats17[playerid], 1);

stats18[playerid] = TextDrawCreate(284.860809, 237.416595, "POSAO");
TextDrawLetterSize(stats18[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats18[playerid], 1);
TextDrawColor(stats18[playerid], -5963521);
TextDrawSetShadow(stats18[playerid], 0);
TextDrawSetOutline(stats18[playerid], 1);
TextDrawBackgroundColor(stats18[playerid], 51);
TextDrawFont(stats18[playerid], 1);
TextDrawSetProportional(stats18[playerid], 1);

stats19[playerid] = TextDrawCreate(284.860778, 249.666641, "Posao: Mlijekar");
TextDrawLetterSize(stats19[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats19[playerid], 1);
TextDrawColor(stats19[playerid], -1);
TextDrawSetShadow(stats19[playerid], 0);
TextDrawSetOutline(stats19[playerid], 1);
TextDrawBackgroundColor(stats19[playerid], 51);
TextDrawFont(stats19[playerid], 1);
TextDrawSetProportional(stats19[playerid], 1);

stats20[playerid] = TextDrawCreate(284.860626, 259.583404, "Skill: 0/500");
TextDrawLetterSize(stats20[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats20[playerid], 1);
TextDrawColor(stats20[playerid], -1);
TextDrawSetShadow(stats20[playerid], 0);
TextDrawSetOutline(stats20[playerid], 1);
TextDrawBackgroundColor(stats20[playerid], 51);
TextDrawFont(stats20[playerid], 1);
TextDrawSetProportional(stats20[playerid], 1);

stats21[playerid] = TextDrawCreate(285.329345, 268.916656, "Ugovor: 0/10");
TextDrawLetterSize(stats21[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats21[playerid], 1);
TextDrawColor(stats21[playerid], -1);
TextDrawSetShadow(stats21[playerid], 0);
TextDrawSetOutline(stats21[playerid], 1);
TextDrawBackgroundColor(stats21[playerid], 51);
TextDrawFont(stats21[playerid], 1);
TextDrawSetProportional(stats21[playerid], 1);

stats22[playerid] = TextDrawCreate(285.797729, 279.416656, "Placa: $350");
TextDrawLetterSize(stats22[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats22[playerid], 1);
TextDrawColor(stats22[playerid], -1);
TextDrawSetShadow(stats22[playerid], 0);
TextDrawSetOutline(stats22[playerid], 1);
TextDrawBackgroundColor(stats22[playerid], 51);
TextDrawFont(stats22[playerid], 1);
TextDrawSetProportional(stats22[playerid], 1);

stats23[playerid] = TextDrawCreate(391.683807, 178.500000, "IMOVINA");
TextDrawLetterSize(stats23[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats23[playerid], 1);
TextDrawColor(stats23[playerid], -5963521);
TextDrawSetShadow(stats23[playerid], 0);
TextDrawSetOutline(stats23[playerid], 1);
TextDrawBackgroundColor(stats23[playerid], 51);
TextDrawFont(stats23[playerid], 1);
TextDrawSetProportional(stats23[playerid], 1);

stats24[playerid] = TextDrawCreate(392.152893, 191.333312, "Vozilo (1) ID: 0");
TextDrawLetterSize(stats24[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats24[playerid], 1);
TextDrawColor(stats24[playerid], -1);
TextDrawSetShadow(stats24[playerid], 0);
TextDrawSetOutline(stats24[playerid], 1);
TextDrawBackgroundColor(stats24[playerid], 51);
TextDrawFont(stats24[playerid], 1);
TextDrawSetProportional(stats24[playerid], 1);

stats25[playerid] = TextDrawCreate(392.620635, 201.833297, "Vozilo (2) ID: 0");
TextDrawLetterSize(stats25[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats25[playerid], 1);
TextDrawColor(stats25[playerid], -1);
TextDrawSetShadow(stats25[playerid], 0);
TextDrawSetOutline(stats25[playerid], 1);
TextDrawBackgroundColor(stats25[playerid], 51);
TextDrawFont(stats25[playerid], 1);
TextDrawSetProportional(stats25[playerid], 1);

stats26[playerid] = TextDrawCreate(392.620635, 212.333251, "Kuca ID: 0");
TextDrawLetterSize(stats26[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats26[playerid], 1);
TextDrawColor(stats26[playerid], -1);
TextDrawSetShadow(stats26[playerid], 0);
TextDrawSetOutline(stats26[playerid], 1);
TextDrawBackgroundColor(stats26[playerid], 51);
TextDrawFont(stats26[playerid], 1);
TextDrawSetProportional(stats26[playerid], 1);

stats27[playerid] = TextDrawCreate(392.620697, 222.249984, "Biznis ID: 0");
TextDrawLetterSize(stats27[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats27[playerid], 1);
TextDrawColor(stats27[playerid], -1);
TextDrawSetShadow(stats27[playerid], 0);
TextDrawSetOutline(stats27[playerid], 1);
TextDrawBackgroundColor(stats27[playerid], 51);
TextDrawFont(stats27[playerid], 1);
TextDrawSetProportional(stats27[playerid], 1);

stats28[playerid] = TextDrawCreate(392.620910, 237.416625, "OSTALO");
TextDrawLetterSize(stats28[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats28[playerid], 1);
TextDrawColor(stats28[playerid], -5963521);
TextDrawSetShadow(stats28[playerid], 0);
TextDrawSetOutline(stats28[playerid], 1);
TextDrawBackgroundColor(stats28[playerid], 51);
TextDrawFont(stats28[playerid], 1);
TextDrawSetProportional(stats28[playerid], 1);

stats29[playerid] = TextDrawCreate(393.089782, 250.249923, "Cigarete: 0/20");
TextDrawLetterSize(stats29[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats29[playerid], 1);
TextDrawColor(stats29[playerid], -1);
TextDrawSetShadow(stats29[playerid], 0);
TextDrawSetOutline(stats29[playerid], 1);
TextDrawBackgroundColor(stats29[playerid], 51);
TextDrawFont(stats29[playerid], 1);
TextDrawSetProportional(stats29[playerid], 1);

stats30[playerid] = TextDrawCreate(393.089385, 261.333282, "Mob. Kredit: $20");
TextDrawLetterSize(stats30[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats30[playerid], 1);
TextDrawColor(stats30[playerid], -1);
TextDrawSetShadow(stats30[playerid], 0);
TextDrawSetOutline(stats30[playerid], 1);
TextDrawBackgroundColor(stats30[playerid], 51);
TextDrawFont(stats30[playerid], 1);
TextDrawSetProportional(stats30[playerid], 1);

stats31[playerid] = TextDrawCreate(393.558013, 271.833343, "OCN: 0");
TextDrawLetterSize(stats31[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats31[playerid], 1);
TextDrawColor(stats31[playerid], -1);
TextDrawSetShadow(stats31[playerid], 0);
TextDrawSetOutline(stats31[playerid], 1);
TextDrawBackgroundColor(stats31[playerid], 51);
TextDrawFont(stats31[playerid], 1);
TextDrawSetProportional(stats31[playerid], 1);

stats32[playerid] = TextDrawCreate(178.975128, 327.833343, "VINTAGE REPUBLIC RPG/DM - DA ZATVORITE UKUCAJTE /STATS");
TextDrawLetterSize(stats32[playerid], 0.182005, 1.179998);
TextDrawAlignment(stats32[playerid], 1);
TextDrawColor(stats32[playerid], -5963521);
TextDrawSetShadow(stats32[playerid], 0);
TextDrawSetOutline(stats32[playerid], 1);
TextDrawBackgroundColor(stats32[playerid], 51);
TextDrawFont(stats32[playerid], 1);
TextDrawSetProportional(stats32[playerid], 1);
//------ MAPA: REMOVE OBJEKTE -------------------------------------------//
//Sadnja droge #1
RemoveBuildingForPlayer(playerid, 3300, -1667.1094, 2551.0625, 86.1172, 0.25);
RemoveBuildingForPlayer(playerid, 3285, -1667.1094, 2551.0625, 86.1172, 0.25);
//Do grada kuce
RemoveBuildingForPlayer(playerid, 3300, -62.3047, 968.3984, 20.6250, 0.2500);
RemoveBuildingForPlayer(playerid, 3301, -95.3438, 967.4375, 20.7109, 0.2500);
RemoveBuildingForPlayer(playerid, 3339, -56.6250, 933.1563, 19.7578, 0.2500);
RemoveBuildingForPlayer(playerid, 3342, -151.0781, 936.0859, 18.2734, 0.2500);
RemoveBuildingForPlayer(playerid, 3173, -151.0781, 936.0859, 18.2734, 0.2500);
RemoveBuildingForPlayer(playerid, 3284, -95.3438, 967.4375, 20.7109, 0.2500);
RemoveBuildingForPlayer(playerid, 3169, -56.6250, 933.1563, 19.7578, 0.2500);
RemoveBuildingForPlayer(playerid, 3285, -62.3047, 968.3984, 20.6250, 0.2500);
//SPAWN SLIKA
RemoveBuildingForPlayer(playerid, 3343, -640.4766, 2717.1953, 71.2656, 0.25);
RemoveBuildingForPlayer(playerid, 3345, -622.4844, 2710.9766, 71.2656, 0.25);
RemoveBuildingForPlayer(playerid, 3172, -622.4844, 2710.9766, 71.2656, 0.25);
//DRUGI Grad
RemoveBuildingForPlayer(playerid, 3341, -941.5781, 1425.4297, 28.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3343, -905.0000, 1541.0547, 24.8672, 0.25);
RemoveBuildingForPlayer(playerid, 3344, -906.4375, 1529.9375, 24.8828, 0.25);
RemoveBuildingForPlayer(playerid, 3344, -831.4375, 1587.5313, 25.8047, 0.25);
RemoveBuildingForPlayer(playerid, 11668, -816.6719, 1602.3516, 27.6875, 0.25);
RemoveBuildingForPlayer(playerid, 11669, -821.4141, 1558.7813, 26.0313, 0.25);
RemoveBuildingForPlayer(playerid, 3170, -941.5781, 1425.4297, 28.9844, 0.25);
RemoveBuildingForPlayer(playerid, 672, -934.7031, 1429.5703, 29.2188, 0.25);
RemoveBuildingForPlayer(playerid, 3171, -906.4375, 1529.9375, 24.8828, 0.25);
RemoveBuildingForPlayer(playerid, 3168, -905.0000, 1541.0547, 24.8672, 0.25);
RemoveBuildingForPlayer(playerid, 649, -853.1484, 1550.7578, 22.4297, 0.25);
RemoveBuildingForPlayer(playerid, 11436, -821.4141, 1558.7813, 26.0313, 0.25);
RemoveBuildingForPlayer(playerid, 11426, -800.8438, 1525.2734, 25.8594, 0.25);
RemoveBuildingForPlayer(playerid, 11433, -788.0391, 1522.6250, 28.0938, 0.25);
RemoveBuildingForPlayer(playerid, 761, -790.6250, 1552.3828, 26.2109, 0.25);
RemoveBuildingForPlayer(playerid, 11437, -775.5938, 1555.6797, 26.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3171, -831.4375, 1587.5313, 25.8047, 0.25);
RemoveBuildingForPlayer(playerid, 11425, -816.6719, 1602.3516, 27.6875, 0.25);
RemoveBuildingForPlayer(playerid, 11566, -792.3984, 1610.1719, 27.4531, 0.25);
RemoveBuildingForPlayer(playerid, 669, -783.1875, 1601.2266, 26.2031, 0.25);

RemoveBuildingForPlayer(playerid, 16287, 412.2500, 1164.1719, 6.8984, 0.25);
RemoveBuildingForPlayer(playerid, 3242, 744.8359, 275.2031, 28.0078, 0.25);
RemoveBuildingForPlayer(playerid, 4514, 440.0469, 587.4453, 19.7344, 0.25);
RemoveBuildingForPlayer(playerid, 4515, 604.5234, 352.5391, 19.7344, 0.25);

RemoveBuildingForPlayer(playerid, 16363, 600.6250, 1652.2109, 6.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 624.0469, 1677.6016, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 16362, 613.7578, 1692.3906, 9.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 603.4844, 1707.2344, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 606.8984, 1702.2188, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 610.2500, 1697.2656, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 613.7188, 1692.2656, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 16360, 641.8438, 1681.9922, 6.1875, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 617.1250, 1687.4531, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1686, 620.5313, 1682.4609, 6.1797, 0.25);
RemoveBuildingForPlayer(playerid, 16747, 616.2734, 1737.7500, 12.8828, 0.25);
RemoveBuildingForPlayer(playerid, 11618, -688.1172, 939.1797, 11.1250, 0.25);
RemoveBuildingForPlayer(playerid, 11654, -681.8750, 965.8906, 11.1250, 0.25);
RemoveBuildingForPlayer(playerid, 691, -760.0547, 940.5000, 6.1875, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -731.9922, 881.8984, 13.4922, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -731.2109, 893.5078, 12.9375, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -730.4297, 905.1172, 12.3828, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -717.4141, 892.3750, 12.9375, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -716.6406, 903.9844, 12.3828, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -698.9609, 909.6719, 11.9688, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -687.3125, 909.6016, 11.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -710.6094, 909.7422, 11.9453, 0.25);
RemoveBuildingForPlayer(playerid, 691, -739.1094, 907.2031, 11.4688, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -729.5313, 916.5391, 12.1250, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -728.7500, 928.1641, 12.1016, 0.25);
RemoveBuildingForPlayer(playerid, 691, -744.9922, 924.6953, 10.0547, 0.25);
RemoveBuildingForPlayer(playerid, 11491, -688.1094, 928.1328, 12.6250, 0.25);
RemoveBuildingForPlayer(playerid, 669, -712.0703, 928.3047, 11.5391, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -727.9688, 939.7891, 12.0859, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -727.1875, 951.4141, 12.0625, 0.25);
RemoveBuildingForPlayer(playerid, 11490, -688.1172, 939.1797, 11.1250, 0.25);
RemoveBuildingForPlayer(playerid, 11631, -691.5938, 942.7188, 13.8750, 0.25);
RemoveBuildingForPlayer(playerid, 11663, -688.1172, 939.1797, 11.1250, 0.25);
RemoveBuildingForPlayer(playerid, 11666, -688.1406, 934.8203, 14.3906, 0.25);
RemoveBuildingForPlayer(playerid, 11664, -685.0938, 941.9141, 13.1406, 0.25);
RemoveBuildingForPlayer(playerid, 11665, -685.1719, 935.6953, 13.3203, 0.25);
RemoveBuildingForPlayer(playerid, 669, -745.9531, 965.4141, 11.8203, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -709.3203, 991.1641, 12.0313, 0.25);
RemoveBuildingForPlayer(playerid, 691, -701.7422, 1006.1328, 11.5859, 0.25);
RemoveBuildingForPlayer(playerid, 700, -700.6563, 984.1406, 11.5547, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -697.6719, 990.9922, 12.0078, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -665.5625, 912.9453, 11.9766, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -675.6641, 909.5313, 12.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1223, -673.2891, 920.3203, 10.9141, 0.25);
RemoveBuildingForPlayer(playerid, 1223, -683.0703, 920.4844, 10.9141, 0.25);
RemoveBuildingForPlayer(playerid, 1223, -664.8516, 920.0625, 10.9141, 0.25);
RemoveBuildingForPlayer(playerid, 700, -658.8203, 936.1797, 11.2500, 0.25);
RemoveBuildingForPlayer(playerid, 11492, -681.8750, 965.8906, 11.1250, 0.25);
RemoveBuildingForPlayer(playerid, 669, -656.5781, 974.4688, 11.2734, 0.25);
RemoveBuildingForPlayer(playerid, 669, -674.0234, 998.0000, 11.4063, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -662.7266, 990.4766, 11.9453, 0.25);
RemoveBuildingForPlayer(playerid, 691, -665.8906, 1004.1797, 11.5859, 0.25);
RemoveBuildingForPlayer(playerid, 691, -652.5547, 999.9063, 11.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -650.1953, 928.1953, 11.8750, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -645.8828, 937.9063, 11.9453, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -645.7109, 949.5547, 11.9688, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -645.5391, 961.2031, 11.9844, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -645.3672, 972.8516, 12.0078, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -645.1953, 984.5000, 12.0313, 0.25);
RemoveBuildingForPlayer(playerid, 3276, -651.0781, 990.3047, 11.9219, 0.25);
RemoveBuildingForPlayer(playerid, 11563, -650.2813, 1039.6719, 22.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -644.3672, 1033.9609, 11.2109, 0.25);
RemoveBuildingForPlayer(playerid, 705, -621.8594, 985.8906, 8.0781, 0.25);
RemoveBuildingForPlayer(playerid, 691, -619.9688, 1019.4297, 8.5703, 0.25);
RemoveBuildingForPlayer(playerid, 3682, 247.9297, 1461.8594, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3682, 192.2734, 1456.1250, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3682, 199.7578, 1397.8828, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1356.9922, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1356.9922, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1392.1563, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1392.1563, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1426.9141, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1426.9141, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3288, 221.5703, 1374.9688, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3289, 212.0781, 1426.0313, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3290, 218.2578, 1467.5391, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1435.1953, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1410.5391, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1385.8906, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1361.2422, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3290, 190.9141, 1371.7734, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3289, 183.7422, 1444.8672, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3289, 222.5078, 1444.6953, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3289, 221.1797, 1390.2969, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3288, 223.1797, 1421.1875, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1459.6406, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3289, 207.5391, 1371.2422, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 16433, -177.4375, 1056.3906, 22.8125, 0.25);
RemoveBuildingForPlayer(playerid, 16441, -32.5234, 1185.1875, 22.4297, 0.25);
RemoveBuildingForPlayer(playerid, 16476, -98.1953, 1180.0703, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16566, -222.1953, 979.2500, 17.3828, 0.25);
RemoveBuildingForPlayer(playerid, 16614, -346.6719, 1595.0781, 79.6641, 0.25);
RemoveBuildingForPlayer(playerid, 16615, -389.7656, 1515.1641, 74.5547, 0.25);
RemoveBuildingForPlayer(playerid, 16616, -326.6953, 1541.3906, 74.5547, 0.25);
RemoveBuildingForPlayer(playerid, 16618, -117.7656, 1079.4609, 22.2188, 0.25);
RemoveBuildingForPlayer(playerid, 3424, 220.6484, 1355.1875, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3424, 221.7031, 1404.5078, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3424, 210.4141, 1444.8438, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3424, 262.5078, 1465.2031, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -315.4922, 802.3125, 15.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -315.4922, 797.0781, 15.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3337, -303.6797, 811.5938, 13.6797, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -315.4922, 814.4922, 14.7656, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -315.4922, 809.2891, 15.3984, 0.25);
RemoveBuildingForPlayer(playerid, 16770, -326.5703, 821.0547, 14.9531, 0.25);
RemoveBuildingForPlayer(playerid, 1493, -316.5859, 829.0781, 13.2344, 0.25);
RemoveBuildingForPlayer(playerid, 773, -310.7656, 822.0547, 12.8125, 0.25);
RemoveBuildingForPlayer(playerid, 16769, -324.0859, 832.0938, 13.2266, 0.25);
RemoveBuildingForPlayer(playerid, 769, -229.2266, 908.2578, 10.5156, 0.25);
RemoveBuildingForPlayer(playerid, 16563, -222.1953, 979.2500, 17.3828, 0.25);
RemoveBuildingForPlayer(playerid, 780, -209.1641, 1005.5625, 18.1797, 0.25);
RemoveBuildingForPlayer(playerid, 16738, -217.4922, 1026.8203, 27.6797, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -169.9766, 1027.1953, 19.4453, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -170.4609, 1029.3672, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16061, -193.3750, 1055.2891, 18.3203, 0.25);
RemoveBuildingForPlayer(playerid, 1522, -180.3125, 1035.5859, 18.7266, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -176.6094, 1052.0625, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 669, -332.4063, 1072.2422, 18.7891, 0.25);
RemoveBuildingForPlayer(playerid, 700, -289.0625, 1074.9766, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 669, -342.0781, 1078.4609, 18.7891, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -169.3594, 1077.4766, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 774, -136.2969, 765.1094, 20.8594, 0.25);
RemoveBuildingForPlayer(playerid, 773, -122.0625, 785.0938, 20.2656, 0.25);
RemoveBuildingForPlayer(playerid, 773, -154.1953, 1012.9453, 18.3281, 0.25);
RemoveBuildingForPlayer(playerid, 774, -82.9688, 1022.7813, 18.6328, 0.25);
RemoveBuildingForPlayer(playerid, 700, -127.8750, 1058.6641, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 780, -147.2500, 1055.5156, 18.8750, 0.25);
RemoveBuildingForPlayer(playerid, 669, -120.4766, 1061.2109, 18.6797, 0.25);
RemoveBuildingForPlayer(playerid, 652, -82.2969, 1060.2734, 18.4531, 0.25);
RemoveBuildingForPlayer(playerid, 769, -96.9453, 1054.9297, 18.0469, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -139.3984, 1067.3516, 19.0547, 0.25);
RemoveBuildingForPlayer(playerid, 691, -51.3516, 1006.5781, 18.5625, 0.25);
RemoveBuildingForPlayer(playerid, 700, -39.0938, 999.8672, 19.0938, 0.25);
RemoveBuildingForPlayer(playerid, 773, 4.9453, 1052.8906, 14.5469, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 75.0547, 1077.6875, 14.1250, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 75.8516, 1041.6797, 13.8516, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 75.9922, 1036.3828, 13.8516, 0.25);
RemoveBuildingForPlayer(playerid, 700, -334.4531, 1085.9922, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 773, -291.2578, 1085.0938, 17.6563, 0.25);
RemoveBuildingForPlayer(playerid, 16434, -180.7109, 1081.0781, 27.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1352, -185.1797, 1087.8438, 18.7109, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -174.3828, 1093.6953, 23.2031, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -146.8438, 1093.6953, 23.2031, 0.25);
RemoveBuildingForPlayer(playerid, 16740, -152.3203, 1144.0703, 30.3047, 0.25);
RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);
RemoveBuildingForPlayer(playerid, 3286, -230.2031, 1185.7734, 23.3516, 0.25);
RemoveBuildingForPlayer(playerid, 16137, -389.7656, 1515.1641, 74.5547, 0.25);
RemoveBuildingForPlayer(playerid, 16138, -326.6953, 1541.3906, 74.5547, 0.25);
RemoveBuildingForPlayer(playerid, 16136, -350.0625, 1594.3438, 75.3125, 0.25);
RemoveBuildingForPlayer(playerid, 16613, -346.6719, 1595.0781, 79.6641, 0.25);
RemoveBuildingForPlayer(playerid, 16386, -117.7656, 1079.4609, 22.2188, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -123.8125, 1079.3984, 19.5000, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -86.8438, 1088.4141, 19.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -90.7891, 1093.6953, 23.2031, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -83.4766, 1108.3750, 20.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -78.2344, 1108.3750, 20.0078, 0.25);
RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -90.9922, 1151.5469, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -88.8594, 1165.3828, 19.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -96.7188, 1164.3516, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -44.3047, 1179.2734, 19.2422, 0.25);
RemoveBuildingForPlayer(playerid, 16475, -98.1953, 1180.0703, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -46.6953, 1179.5703, 18.5703, 0.25);
RemoveBuildingForPlayer(playerid, 1352, -109.9453, 1188.0156, 18.7109, 0.25);
RemoveBuildingForPlayer(playerid, 1522, -53.1016, 1188.3281, 18.3438, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -76.5313, 1187.6406, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -81.7188, 1193.6406, 23.2031, 0.25);
RemoveBuildingForPlayer(playerid, 16146, -97.2344, 1373.2031, 12.4063, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -104.2109, 1376.5156, 10.4688, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -102.0391, 1364.3516, 10.4688, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -105.1406, 1366.4766, 10.4688, 0.25);
RemoveBuildingForPlayer(playerid, 16778, -79.9375, 1385.5938, 9.0000, 0.25);
RemoveBuildingForPlayer(playerid, 1493, -89.8984, 1377.4219, 9.4609, 0.25);
RemoveBuildingForPlayer(playerid, 761, 12.0156, 1159.5703, 18.8281, 0.25);
RemoveBuildingForPlayer(playerid, 1468, 11.4063, 1160.0234, 19.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1468, 6.1328, 1160.0234, 19.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1468, 0.8594, 1160.0234, 19.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -24.8203, 1165.4063, 19.2422, 0.25);
RemoveBuildingForPlayer(playerid, 16442, -18.4688, 1178.8828, 29.3750, 0.25);
RemoveBuildingForPlayer(playerid, 955, -14.7031, 1175.3594, 18.9531, 0.25);
RemoveBuildingForPlayer(playerid, 761, -13.6953, 1187.4063, 18.4766, 0.25);
RemoveBuildingForPlayer(playerid, 16068, -32.5234, 1185.1875, 22.4297, 0.25);
RemoveBuildingForPlayer(playerid, 761, -13.7891, 1185.4922, 18.4766, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -25.7813, 1188.0313, 18.6328, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -25.7813, 1193.6406, 22.8125, 0.25);
RemoveBuildingForPlayer(playerid, 1468, 16.6875, 1160.0234, 19.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1468, 21.9609, 1160.0234, 19.9453, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 40.5625, 1188.6875, 17.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 66.7969, 1207.1563, 18.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 72.0859, 1206.8828, 18.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 73.0938, 1228.0391, 19.0781, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 74.6484, 1082.9453, 14.1250, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 77.3594, 1206.8828, 18.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 76.9297, 1187.2969, 17.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 82.2344, 1028.6719, 13.8359, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 78.3125, 1032.2031, 13.8359, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 85.9844, 1024.9297, 13.8359, 0.25);
RemoveBuildingForPlayer(playerid, 16000, 110.8125, 1023.9922, 12.6484, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 130.3828, 1029.3516, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 134.8984, 1032.1250, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 137.1328, 1036.2422, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 94.9688, 1067.2031, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 108.9688, 1067.2031, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 96.8750, 1057.2188, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 98.6484, 1047.6563, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 91.3750, 1085.6719, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 105.3750, 1085.6719, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 100.1406, 1076.7891, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 107.1406, 1076.7891, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 112.3750, 1085.6719, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 115.9688, 1067.2031, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 110.8750, 1057.2188, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 112.6484, 1047.6563, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 121.1406, 1076.7891, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 128.1406, 1076.7891, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 122.9688, 1067.2031, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 124.8750, 1057.2188, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 3221, 119.6484, 1047.6563, 12.6641, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 139.7734, 1052.9609, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 141.6797, 1071.9844, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 141.0391, 1066.7500, 13.7969, 0.25);
RemoveBuildingForPlayer(playerid, 691, 92.4141, 1099.5313, 12.2031, 0.25);
RemoveBuildingForPlayer(playerid, 691, 79.3359, 1099.9453, 11.9219, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 97.1172, 1107.4141, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 97.2578, 1102.1172, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 16001, 110.6172, 1109.5156, 12.7266, 0.25);
RemoveBuildingForPlayer(playerid, 691, 141.7656, 1109.8828, 11.8906, 0.25);
RemoveBuildingForPlayer(playerid, 669, 131.4766, 1109.2734, 12.5078, 0.25);
RemoveBuildingForPlayer(playerid, 16002, 172.8047, 1088.6250, 18.1094, 0.25);
RemoveBuildingForPlayer(playerid, 691, 160.6875, 1106.7344, 13.5547, 0.25);
RemoveBuildingForPlayer(playerid, 669, 147.9219, 1090.0625, 12.5078, 0.25);
RemoveBuildingForPlayer(playerid, 16003, 150.2344, 1105.5313, 14.6328, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 98.8359, 1115.2734, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 96.7031, 1112.6719, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 104.1250, 1115.0000, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 109.3984, 1115.0000, 13.8906, 0.25);
RemoveBuildingForPlayer(playerid, 16280, 293.6094, 1148.1797, 11.3047, 0.25);
RemoveBuildingForPlayer(playerid, 1308, 319.6406, 1144.3828, 7.6484, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 78.2578, 1226.8516, 19.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1413, 83.2813, 1225.2656, 19.8203, 0.25);
RemoveBuildingForPlayer(playerid, 3259, 220.6484, 1355.1875, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1356.9922, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1356.9922, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 691, 281.2109, 1172.5078, 9.8125, 0.25);
RemoveBuildingForPlayer(playerid, 700, 276.1719, 1164.0313, 10.0781, 0.25);
RemoveBuildingForPlayer(playerid, 669, 301.4219, 1175.6719, 8.7500, 0.25);
RemoveBuildingForPlayer(playerid, 669, 318.2813, 1171.8672, 7.8672, 0.25);
RemoveBuildingForPlayer(playerid, 3256, 190.9141, 1371.7734, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1392.1563, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1392.1563, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3258, 207.5391, 1371.2422, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1394.1328, 10.1172, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1392.1563, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1394.1328, 23.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 207.3594, 1390.5703, 19.1484, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1387.8516, 27.4922, 0.25);
RemoveBuildingForPlayer(playerid, 3673, 199.7578, 1397.8828, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3257, 221.5703, 1374.9688, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3258, 221.1797, 1390.2969, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 203.9531, 1409.9141, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3674, 199.3828, 1407.1172, 35.8984, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 204.6406, 1409.8516, 11.4063, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1404.2344, 18.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1400.6563, 22.4688, 0.25);
RemoveBuildingForPlayer(playerid, 3259, 221.7031, 1404.5078, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 207.3594, 1409.0000, 19.7578, 0.25);
RemoveBuildingForPlayer(playerid, 3257, 223.1797, 1421.1875, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3258, 212.0781, 1426.0313, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1426.9141, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1426.9141, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1361.2422, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1385.8906, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1410.5391, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3258, 183.7422, 1444.8672, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3259, 210.4141, 1444.8438, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3258, 222.5078, 1444.6953, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 16086, 232.2891, 1434.4844, 13.5000, 0.25);
RemoveBuildingForPlayer(playerid, 3673, 192.2734, 1456.1250, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3674, 183.0391, 1455.7500, 35.8984, 0.25);
RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1459.6406, 17.0938, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 196.0234, 1462.0156, 10.1172, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 198.0000, 1462.0156, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 196.0234, 1462.0156, 23.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 180.2422, 1460.3203, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 180.3047, 1461.0078, 11.4063, 0.25);
RemoveBuildingForPlayer(playerid, 3256, 218.2578, 1467.5391, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 199.5859, 1463.7266, 19.1484, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 181.1563, 1463.7266, 19.7578, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 185.9219, 1462.8750, 18.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 202.3047, 1462.8750, 27.4922, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 189.5000, 1462.8750, 22.4688, 0.25);
RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1435.1953, 9.6875, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1451.8281, 27.4922, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1458.1094, 23.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 255.5313, 1454.5469, 19.1484, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1456.1328, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1458.1094, 10.1172, 0.25);
RemoveBuildingForPlayer(playerid, 3259, 262.5078, 1465.2031, 9.5859, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1468.2109, 18.2969, 0.25);
RemoveBuildingForPlayer(playerid, 3673, 247.9297, 1461.8594, 33.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1464.6328, 22.4688, 0.25);
RemoveBuildingForPlayer(playerid, 3674, 247.5547, 1471.0938, 35.8984, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 255.5313, 1472.9766, 19.7578, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 252.8125, 1473.8281, 11.4063, 0.25);
RemoveBuildingForPlayer(playerid, 3675, 252.1250, 1473.8906, 16.2969, 0.25);
RemoveBuildingForPlayer(playerid, 16087, 358.6797, 1430.4531, 11.6172, 0.25);
RemoveBuildingForPlayer(playerid, 3279, 113.3828, 1814.4531, 16.8203, 0.25);
RemoveBuildingForPlayer(playerid, 3280, 245.3750, 1862.3672, 20.1328, 0.25);
RemoveBuildingForPlayer(playerid, 3280, 246.6172, 1863.3750, 20.1328, 0.25);
//------------------------------------------------------------------------//

	TextDrawShowForPlayer(playerid, Welcome0);
	TextDrawShowForPlayer(playerid, Welcome1);
	TextDrawShowForPlayer(playerid, Welcome2);
	TextDrawShowForPlayer(playerid, Welcome3);
	TextDrawShowForPlayer(playerid, Welcome4);
	TextDrawShowForPlayer(playerid, Welcome5);
	TextDrawShowForPlayer(playerid, Welcome6);
	TextDrawShowForPlayer(playerid, Welcome7);
	TextDrawShowForPlayer(playerid, Welcome8);
	TextDrawShowForPlayer(playerid, Welcome9);
	TextDrawShowForPlayer(playerid, Welcome10);
	TextDrawShowForPlayer(playerid, Welcome11);
	TextDrawShowForPlayer(playerid, Welcome12);
	TextDrawShowForPlayer(playerid, Welcome13);
	TextDrawShowForPlayer(playerid, Welcome14);
	TextDrawShowForPlayer(playerid, Welcome15);
	SetTimerEx("MyTimer", 4800, false, "i", playerid);
    gOoc[ playerid ] = 0; Logged[ playerid ] = 0;
    // Reset stats!
    PlayerInfo[ playerid ][ pCash ] = 0;
    PlayerInfo[ playerid ][ pAdmin ] = 0;
    PlayerInfo[ playerid ][ pSex ] = 0;
    PlayerInfo[ playerid ][ pAge ] = 0;
    PlayerInfo[ playerid ][ pPos_x ] = 0.0;
    PlayerInfo[ playerid ][ pPos_y ] = 0.0;
    PlayerInfo[ playerid ][ pPos_z ] = 0.0;
    PlayerInfo[ playerid ][ pSkin ] = 0;
    PlayerInfo[ playerid ][ pTeam ] = 0;
    PlayerInfo[ playerid ][ pAccent ] = 0;

    return 1;
}

public OnGameModeInit()
{
	//Starinska kuca, treba dodat novu velicinu kuce
	CreateDynamicObject(19458,-2711.8173800,371.4933200,-30.4287700,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2708.3696300,371.4932900,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,371.4932900,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,371.4932900,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2697.9587400,371.4932900,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2694.5368700,371.4932900,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2711.8122600,381.0571000,-30.4287700,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2708.3696300,381.0571000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,381.0571000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,381.0571000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2697.9587400,381.0571000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2694.5368700,381.0571000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-2713.4257800,368.3463100,-28.7269400,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2713.4257800,371.5488000,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2713.4257800,374.7297100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2713.4257800,377.8700000,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2711.8757300,379.3135100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2708.7299800,379.3088100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2705.5874000,379.3088100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2702.4455600,379.3088100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2699.3046900,379.3088100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2696.2041000,379.3088100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2693.0690900,379.3285200,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2692.8769500,377.8801600,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2692.8769500,374.7297100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2692.8769500,371.5488000,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2692.8769500,368.3463100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2698.6455100,377.8695700,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2698.6455100,374.7297100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2698.6455100,368.3463100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2693.0488300,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2696.2041000,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2699.2849100,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19458,-2697.9587400,362.1145000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,362.1145000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,362.1145000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2708.3696300,362.1145000,-30.4288000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-2711.8757300,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2708.7299800,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2705.5874000,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19386,-2702.4348100,366.9692100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19386,-2698.6455100,371.5356100,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2696.4514200,365.3750900,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2696.4514200,362.1969900,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2696.4514200,359.0773000,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2696.2041000,357.5270100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2699.2849100,357.5270100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2705.5874000,357.5270100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2708.7299800,357.5270100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2702.4609400,357.5270100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,-2705.3659700,365.3750900,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2705.3659700,362.1969900,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2696.4514200,-2705.3659700,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,-2705.3659700,359.0773000,-28.7269000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19458,-2697.9587400,362.1145000,-27.0665100,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,362.1145000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,362.1145000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2711.8173800,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2708.3696300,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2697.9587400,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2694.5368700,371.4932900,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2694.5368700,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2697.9587400,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2711.8122600,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2708.3696300,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2704.8894000,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,-2701.4431200,381.0571000,-27.0665000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(1496,-2713.3168900,371.5049100,-30.4104000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(1491,-2698.6550300,370.7970300,-30.4813600,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(1491,-2703.2185100,366.9281300,-30.4814000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1516,-2704.8955100,372.0255100,-30.2314200,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1516,-2705.9096700,372.0255100,-30.2314000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2120,-2703.6594200,372.0531600,-29.8270500,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2120,-2707.0803200,372.0390600,-29.8270000,0.0000000,0.0000000,167.1000200); //
CreateDynamicObject(2120,-2704.9582500,373.0783100,-29.8270000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(2120,-2706.0188000,373.0699200,-29.8270000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(2120,-2704.7055700,370.9862700,-29.8270000,0.0000000,0.0000000,-63.6599800); //
CreateDynamicObject(2120,-2705.9394500,371.2862200,-29.8270000,0.0000000,0.0000000,-127.9200200); //
CreateDynamicObject(2323,-2700.1108400,377.4170200,-30.5723000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2161,-2698.7175300,378.7419100,-30.3771000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2161,-2698.7175300,375.4735100,-30.3771000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(1518,-2699.0996100,376.9143100,-29.3105300,0.0000000,0.0000000,-89.3999900); //
CreateDynamicObject(1729,-2701.8449700,374.7709700,-30.3410000,0.0000000,0.0000000,143.8799600); //
CreateDynamicObject(1728,-2703.1074200,375.7147800,-30.3612600,0.0000000,0.0000000,90.1200000); //
CreateDynamicObject(1764,-2702.1037600,378.8387500,-30.3414900,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2096,-2712.6911600,377.3341100,-30.3817300,0.0000000,0.0000000,106.8000300); //
CreateDynamicObject(2096,-2712.3335000,378.5221600,-30.3817300,0.0000000,0.0000000,33.0600400); //
CreateDynamicObject(1433,-2711.6962900,377.5547800,-30.1594300,0.0000000,0.0000000,204.3598800); //
CreateDynamicObject(2573,-2709.5627400,367.5445900,-30.3419000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(1742,-2708.6362300,379.3604100,-30.3424000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1742,-2707.2270500,379.3604100,-30.3424000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2709.5317400,378.8483900,-30.3700600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2705.9458000,378.8885800,-30.4100100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2699.0417500,374.2671200,-30.4100100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2712.9670400,374.0963700,-30.3700600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2712.9653300,374.7366900,-30.3700600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2708.9003900,367.5236200,-30.3700600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2712.9816900,367.5479400,-30.3700600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2699.1743200,367.3710900,-30.3700600,0.0000000,0.0000000,1.9200000); //
CreateDynamicObject(2156,-2693.4331100,367.2484100,-30.3422000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(2156,-2694.7822300,367.2484100,-30.3422000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(2157,-2696.1096200,367.2484100,-30.3422000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(2157,-2693.1477100,367.9390900,-30.3422000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2160,-2693.1477100,369.2645900,-30.3422000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2159,-2693.1477100,370.5878900,-30.3422000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2149,-2693.4953600,367.6419100,-29.1380000,0.0000000,0.0000000,-135.8400000); //
CreateDynamicObject(2303,-2693.3942900,370.7763100,-30.3572000,0.0000000,0.0000000,-90.3000000); //
CreateDynamicObject(2157,-2693.1477100,371.9453100,-30.3422000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2158,-2693.4677700,372.9154100,-30.3422000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(1808,-2693.3308100,373.7466700,-30.3905100,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(19366,-2693.9492200,375.8145100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19386,-2697.1284200,375.8145100,-28.7269000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(1491,-2697.8938000,375.7725500,-30.4814000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2528,-2693.4807100,377.5807500,-30.3542400,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2523,-2698.0012200,378.7246100,-30.3539000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2527,-2694.4135700,378.7728900,-30.3542000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2134,-2697.5239300,379.2591900,-28.8993000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2134,-2697.5239300,379.1471900,-30.5691000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2698.0722700,367.4798300,-30.3700600,0.0000000,0.0000000,17.4600000); //
CreateDynamicObject(948,-2693.5163600,375.1440100,-30.3700600,0.0000000,0.0000000,17.4600000); //
CreateDynamicObject(948,-2693.2966300,376.2044400,-30.3701000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2696.2500000,378.8969100,-30.5295700,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2299,-2700.5288100,361.1413000,-30.4860000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(2296,-2699.0395500,365.9975000,-30.3418700,0.0000000,0.0000000,-31.6199900); //
CreateDynamicObject(2230,-2696.8767100,357.5441300,-30.4488600,0.0000000,0.0000000,-130.4399900); //
CreateDynamicObject(2230,-2705.3740200,357.8573300,-30.4488600,0.0000000,0.0000000,-225.0600000); //
CreateDynamicObject(2295,-2697.7419400,363.0995500,-30.3596600,0.0000000,0.0000000,-159.2999600); //
CreateDynamicObject(2295,-2699.3520500,363.6823700,-30.3596600,0.0000000,0.0000000,-238.3199900); //
CreateDynamicObject(2133,-2699.3630400,358.0662800,-30.4247700,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(2191,-2704.8142100,359.3207100,-30.4859000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(2096,-2702.7739300,358.1984900,-30.3823000,0.0000000,0.0000000,169.1400000); //
CreateDynamicObject(948,-2704.9658200,360.6722700,-30.3549700,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2704.7387700,366.5009500,-30.3749600,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(948,-2699.8928200,366.4521200,-30.3749600,0.0000000,0.0000000,0.0000000); //
	//Motel Kuca, Interior custom, velicina 0
CreateDynamicObject(19458,1195.9637500,2771.0310100,-14.2419000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,1192.5075700,2771.0310100,-14.2419000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,1189.0688500,2771.0310100,-14.2419000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,1187.4887700,2767.9008800,-12.4819300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1187.4887700,2771.0217300,-12.4819000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1187.4887700,2774.1425800,-12.4819000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1189.1396500,2766.4924300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,1192.2608600,2766.4924300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,1195.3416700,2766.4924300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,1196.7415800,2768.1123000,-12.4819300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1196.7415800,2771.0217300,-12.4819000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1196.7415800,2774.1425800,-12.4819000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19366,1195.2063000,2775.5195300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,1192.2608600,2775.5195300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19366,1189.1396500,2775.5195300,-12.4819000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19458,1189.0688500,2771.0310100,-10.8755700,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,1192.5075700,2771.0310100,-10.8756000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19458,1195.9637500,2771.0310100,-10.8756000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(1493,1192.2680700,2766.5752000,-14.2146900,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2299,1189.1543000,2771.9616700,-14.2919000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2339,1196.1720000,2775.0495600,-14.2348300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2339,1195.2264400,2775.0485800,-14.2348300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2339,1196.3342300,2774.3359400,-14.2348000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2339,1196.3298300,2773.4150400,-14.2348000,0.0000000,0.0000000,-90.0000000); //
CreateDynamicObject(2161,1190.0672600,2766.9152800,-14.2172000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2329,1191.4133300,2774.1350100,-14.2083100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2323,1189.5802000,2768.2294900,-14.5924900,0.0000000,0.0000000,152.4001500); //
CreateDynamicObject(2161,1191.3579100,2766.9436000,-14.2172000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1518,1188.6989700,2767.5344200,-13.3435500,0.0000000,0.0000000,152.7001000); //
CreateDynamicObject(1764,1189.2673300,2770.4924300,-14.1546200,0.0000000,0.0000000,-32.8200000); //
CreateDynamicObject(1720,1188.2884500,2769.4919400,-14.1749100,0.0000000,0.0000000,27.1200000); //
CreateDynamicObject(1720,1190.6630900,2768.2094700,-14.1749100,0.0000000,0.0000000,-66.9600000); //
CreateDynamicObject(2762,1195.9814500,2770.9729000,-13.8156000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(1720,1195.9417700,2772.0571300,-14.1540300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1720,1196.0346700,2769.8757300,-14.1940000,0.0000000,0.0000000,180.0000000); //
CreateDynamicObject(1720,1195.0476100,2771.5766600,-14.1540000,0.0000000,0.0000000,73.3799900); //
CreateDynamicObject(1720,1195.1212200,2770.2797900,-14.1540000,0.0000000,0.0000000,121.8599600); //
CreateDynamicObject(1808,1194.4454300,2775.1709000,-14.2113100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1658,1191.8878200,2771.2631800,-11.3349400,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2277,1190.0372300,2774.9414100,-12.8421900,0.0000000,0.0000000,0.0000000); //
	//Pokraj grada kuce
	CreateDynamicObject(19458, -116.0762, 959.6140, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -117.6100, 954.8675, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -119.1414, 956.4167, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -123.8810, 957.9224, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -128.6121, 959.5493, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -120.8453, 964.3415, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -128.6121, 959.5493, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -116.0762, 959.6140, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -120.8449, 964.3615, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -128.6083, 962.6857, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -128.6083, 962.6857, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -123.8810, 957.9224, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -127.1042, 964.3479, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -127.1042, 964.3479, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(1493, -121.5709, 957.8302, 19.5790, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -123.1454, 959.3534, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -121.5231, 959.3534, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -123.8722, 956.5431, 19.9576, 0.0000, 90.0000, 90.0000);
	CreateDynamicObject(19366, -122.6006, 953.1912, 19.3337, 0.0000, 68.5294, 90.0000);
	CreateDynamicObject(1308, -128.5505, 954.9270, 22.7611, 0.0000, 180.0000, 0.0000);
	CreateDynamicObject(1308, -124.3348, 954.9270, 22.7611, 0.0000, 180.0000, 0.0000);
	CreateDynamicObject(1308, -120.9457, 954.9270, 22.7611, 0.0000, 180.0000, -24.0000);
	CreateDynamicObject(19452, -127.6293, 959.6628, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19452, -124.1278, 959.6628, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19452, -120.6451, 959.6628, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19452, -117.1846, 959.6628, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19458, -100.5088, 954.7778, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -95.7819, 956.2642, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -94.2619, 957.8086, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19458, -92.7459, 962.5321, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -97.4819, 967.2715, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19366, -103.7248, 967.2700, 21.2683, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19458, -105.2423, 959.5031, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -105.2470, 965.7496, 21.2683, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19452, -101.0172, 956.0631, 22.9926, 0.0000, 90.0000, 90.0000);
	CreateDynamicObject(19452, -101.0172, 959.5224, 22.9926, 0.0000, 90.0000, 90.0000);
	CreateDynamicObject(19452, -101.0172, 962.9623, 22.9926, 0.0000, 90.0000, 90.0000);
	CreateDynamicObject(19452, -101.0172, 966.3646, 22.9926, 0.0000, 90.0000, 90.0000);
	CreateDynamicObject(19452, -94.4960, 963.2912, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19360, -94.4597, 955.8984, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19360, -94.4597, 958.3547, 22.9927, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(19452, -91.0105, 963.2912, 22.9926, 0.0000, 90.0000, 0.0000);
	CreateDynamicObject(1308, -92.9510, 954.4647, 22.7416, 0.0000, 180.0000, -24.0000);
	CreateDynamicObject(1308, -89.5221, 958.6975, 22.7416, 0.0000, 180.0000, -24.0000);
	CreateDynamicObject(1308, -89.5297, 967.9120, 22.7416, 0.0000, 180.0000, -24.0000);
	CreateDynamicObject(1493, -93.5111, 957.7300, 19.2523, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -94.2619, 957.8087, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19458, -92.7459, 962.5321, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -95.7818, 956.2642, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19458, -100.5088, 954.7778, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19458, -105.2423, 959.5031, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -105.2470, 965.7496, 17.7931, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19366, -103.7248, 967.2700, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(19458, -97.4819, 967.2715, 17.7931, 0.0000, 0.0000, 90.0000);
	CreateDynamicObject(18267, -61.0734, 968.5972, 20.0768, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(19366, -66.6622, 973.4246, 21.4002, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(19366, -56.7235, 973.9384, 21.4002, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(19366, -53.7968, 967.1899, 21.4002, 0.0000, 0.0000, 3.5400);
	CreateDynamicObject(19366, -53.9967, 971.3677, 21.4002, 0.0000, 0.0000, 3.5400);
	CreateDynamicObject(19366, -56.2991, 963.8264, 21.4002, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(1494, -62.3543, 973.6866, 20.0925, 0.0000, 0.0000, 3.3000);
	CreateDynamicObject(19366, -61.2376, 973.7240, 24.2651, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(19366, -59.7354, 972.2686, 24.2651, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -59.7493, 969.1293, 24.2651, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -62.7518, 972.1103, 24.2651, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -62.7482, 968.9926, 24.2651, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(19366, -61.2587, 972.6102, 25.8909, 0.0000, 90.0000, 181.0199);
	CreateDynamicObject(19366, -61.1988, 969.5053, 25.8909, 0.0000, 90.0000, 181.0199);
	CreateDynamicObject(19366, -66.5286, 963.3845, 21.4612, 0.0000, 0.0000, 92.9998);
	CreateDynamicObject(3253, -146.9423, 935.7266, 18.7463, 0.0000, 0.0000, 90.7201);
	CreateDynamicObject(3253, -146.9903, 939.6565, 18.7463, 0.0000, 0.0000, 90.7201);
	CreateDynamicObject(3250, -130.2817, 938.5673, 18.2711, 0.0000, 0.0000, 267.3000);
	CreateDynamicObject(3250, -116.4630, 940.1645, 19.7409, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(3250, -103.3421, 940.1646, 19.7409, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(669, -135.4126, 948.1211, 17.2689, 3.1416, 0.0000, -23.9424);
	CreateDynamicObject(849, -79.0057, 956.5673, 19.4006, 0.0000, 0.0000, -40.3800);
	CreateDynamicObject(849, -114.2147, 957.1313, 19.8520, 0.0000, 0.0000, 168.5999);
	CreateDynamicObject(1811, -127.8019, 955.7646, 20.6093, 0.0000, 0.0000, 126.8400);
	CreateDynamicObject(1811, -126.2687, 956.8461, 20.6093, 0.0000, 0.0000, 68.9400);
	CreateDynamicObject(1811, -98.6320, 944.4323, 19.8110, -78.0000, 90.0000, -21.0000);
	CreateDynamicObject(669, -84.9158, 946.8762, 18.5202, 3.1416, 0.0000, 2.2776);
	CreateDynamicObject(669, -74.5264, 937.1408, 18.7394, 3.1416, 0.0000, 2.2776);
	CreateDynamicObject(3250, -61.8617, 941.2795, 19.0010, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(3250, -49.2141, 941.0770, 18.6568, 0.0000, 0.0000, 180.0000);
	CreateDynamicObject(3285, -59.0808, 930.2549, 21.7205, 0.0000, 0.0000, 274.5601);
	CreateDynamicObject(650, -113.7807, 963.4473, 19.5231, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(650, -101.0361, 977.0709, 19.5231, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(650, -96.6602, 973.9524, 19.5231, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(650, -96.3913, 937.1176, 19.2039, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(809, -127.6682, 945.7341, 18.6825, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(809, -101.2749, 971.1343, 17.8871, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(809, -96.5904, 970.3481, 17.8871, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(809, -94.9271, 976.4603, 17.8871, 0.0000, 0.0000, 103.5000);
	CreateDynamicObject(809, -79.9836, 967.7518, 17.8871, 0.0000, 0.0000, 103.5000);
	CreateDynamicObject(809, -84.9292, 972.1005, 17.8871, 0.0000, 0.0000, 103.5000);
	CreateDynamicObject(809, -80.6919, 974.6966, 17.8871, 0.0000, 0.0000, 103.5000);
	CreateDynamicObject(809, -90.1378, 943.6801, 17.8871, 0.0000, 0.0000, 103.5000);
	CreateDynamicObject(824, -80.8570, 943.2182, 19.3580, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(824, -96.1322, 918.2054, 19.3580, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(824, -75.0726, 920.1027, 20.8579, 0.0000, 0.0000, 0.0000);
	CreateDynamicObject(3252, -54.8871, 957.4185, 18.5248, 356.8584, 0.0000, 3.1416);
	//AREA
CreateDynamicObject(1280, -2284.7244, -1641.7330, 482.8103, 0.0000, 0.0000, 262.9800);
CreateDynamicObject(1280, -2285.3877, -1647.7616, 482.5964, 0.0000, 0.0000, 83.8200);
CreateDynamicObject(1280, -2287.8628, -1644.5409, 482.7365, 0.0000, 0.0000, -4.2600);
CreateDynamicObject(1303, -2283.2212, -1643.6675, 481.8921, 0.0000, 0.0000, 229.7398);
CreateDynamicObject(1303, -2283.2434, -1644.6453, 481.8589, 0.0000, 0.0000, 283.3201);
CreateDynamicObject(1303, -2283.3516, -1645.8889, 481.8818, 0.0000, 0.0000, 171.1801);
CreateDynamicObject(1303, -2283.8623, -1646.4170, 481.8818, 0.0000, 0.0000, 171.1801);
CreateDynamicObject(1303, -2283.9709, -1642.9161, 481.8921, 0.0000, 0.0000, 271.5598);
CreateDynamicObject(1303, -2284.2317, -1642.7983, 481.8921, 0.0000, 0.0000, 179.0999);
CreateDynamicObject(1303, -2284.7673, -1642.6945, 481.8921, 0.0000, 0.0000, 179.0999);
CreateDynamicObject(1303, -2285.0447, -1646.7094, 481.8818, 0.0000, 0.0000, 99.4200);
CreateDynamicObject(1303, -2285.3240, -1642.5898, 481.8921, 0.0000, 0.0000, 252.0599);
CreateDynamicObject(1303, -2286.1101, -1646.1796, 481.8818, 0.0000, 0.0000, -52.0800);
CreateDynamicObject(1303, -2286.1401, -1642.9335, 481.8921, 0.0000, 0.0000, -19.0200);
CreateDynamicObject(1303, -2286.6519, -1645.7755, 481.8624, 0.0000, 0.0000, -33.2400);
CreateDynamicObject(1303, -2286.6604, -1643.3429, 481.8921, 0.0000, 0.0000, -19.0200);
CreateDynamicObject(1303, -2286.7961, -1643.7318, 481.8921, 0.0000, 0.0000, -125.6400);
CreateDynamicObject(1303, -2286.9853, -1645.3364, 481.8921, 0.0000, 0.0000, 45.1800);
CreateDynamicObject(1303, -2287.0591, -1644.5961, 481.8921, 0.0000, 0.0000, 10.5000);
CreateDynamicObject(16327, -2349.7629, -1640.6919, 482.5376, 0.0000, 0.0000, 1.5600);
CreateDynamicObject(16601, -2304.5991, -1675.5282, 486.4475, 0.0000, 0.0000, 28.6200);
CreateDynamicObject(16601, -2349.8088, -1632.3618, 487.2516, 0.0000, 0.0000, 0.7800);
CreateDynamicObject(19913, -2288.3438, -1622.1824, 486.2046, 0.0000, 0.0000, -71.0400);
CreateDynamicObject(19913, -2292.0762, -1667.7704, 486.2046, 0.0000, 0.0000, 61.6800);
CreateDynamicObject(19913, -2319.2986, -1588.5044, 486.2046, 0.0000, 0.0000, -23.7600);
CreateDynamicObject(19913, -2327.6567, -1681.9341, 486.2046, 0.0000, 0.0000, -18.2400);
CreateDynamicObject(19913, -2350.1699, -1601.7180, 486.2046, 0.0000, 0.0000, 71.6400);
CreateDynamicObject(19913, -2354.0352, -1650.0848, 486.2046, 0.0000, 0.0000, 99.1800);
CreateDynamicObject(3255, -2323.4194, -1637.1728, 482.6269, 0.0000, 0.0000, 91.1401);
CreateDynamicObject(3256, -2319.9939, -1624.5018, 482.7142, 0.0000, 0.0000, 178.9800);
CreateDynamicObject(3269, -2314.8376, -1668.5416, 482.5635, 0.0000, 0.0000, -54.9600);
CreateDynamicObject(3277, -2300.7966, -1602.3914, 482.4083, 0.0000, 0.0000, 126.9000);
CreateDynamicObject(3279, -2332.9753, -1597.5834, 482.6111, 0.0000, 0.0000, 67.0800);
CreateDynamicObject(3515, -2284.9221, -1644.7499, 481.8065, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3594, -2321.2996, -1628.5742, 483.3709, -11.4279, 0.0000, -90.3600);
CreateDynamicObject(3594, -2324.1543, -1627.0547, 482.9476, 0.0000, 0.0000, 0.0000);
	//NOVA POLICIJA
tmpobjid = CreateDynamicObject(19362, -165.584472, 1086.794921, 19.017320, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1083.659301, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1080.476440, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1077.299804, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1074.113891, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1070.927001, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -165.584503, 1067.739501, 19.017299, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -164.066864, 1066.223022, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -162.567855, 1067.756103, 19.017299, 0.000000, 0.000000, 180.419967);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -162.584259, 1070.936157, 19.017299, 0.000000, 0.000000, 180.419967);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -164.062500, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -160.919570, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -157.702896, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -151.460906, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -148.280899, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -145.139297, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -141.973098, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -138.824996, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -135.679504, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -132.539505, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(19362, -120.428901, 1088.296264, 19.017299, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
tmpobjid = CreateDynamicObject(970, -149.689147, 1077.095581, 19.230840, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
tmpobjid = CreateDynamicObject(970, -149.689102, 1086.173583, 19.230800, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
tmpobjid = CreateDynamicObject(970, -151.337997, 1077.104858, 19.230800, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
tmpobjid = CreateDynamicObject(970, -151.337997, 1086.189575, 19.230800, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
tmpobjid = CreateDynamicObject(3439, -121.942306, 1088.320312, 19.651800, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFF0033CC);
tmpobjid = CreateDynamicObject(3439, -131.142944, 1088.287719, 19.651800, 0.000000, 0.000000, 0.000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFF0033CC);
tmpobjid = CreateDynamicObject(970, -153.296600, 1076.800537, 19.230800, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
tmpobjid = CreateDynamicObject(970, -158.672424, 1076.802856, 19.230800, 0.000000, 0.000000, 90.000000);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall01", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF660000);
	//Drvosjeca posao & Drvosjeca meni
	CreateDynamic3DTextLabel(""STRING_GREEN"[ DRVOSJECA ]\n"STRING_WHITE"Da se zaposlite \nukucajte "STRING_GREEN"/takejob", COLOR_YELLOW, -537.2394,-97.8130,63.2969, 15.0);
	CreateDynamicPickup(1239, 1, -537.2394,-97.8130,63.2969, 0, 0, -1);

	CreateDynamic3DTextLabel(""STRING_YELLOW"[ DRVOSJECA ]\n"STRING_WHITE"da vidite opcije ukucajte "STRING_YELLOW"/drvosjeca", COLOR_YELLOW, -525.9680,-95.6334,62.7603, 15.0);
	CreateDynamicPickup(1274, 1, -525.9680,-95.6334,62.7603, 0, 0, -1);
	//Droga posao & Droga meni
	CreateDynamic3DTextLabel(""STRING_GREEN"[ UZGAJIVAC DROGE ]\n"STRING_WHITE"Da se zaposlite \nukucajte "STRING_GREEN"/takejob", COLOR_YELLOW, -636.5583,1446.6155,13.9965, 15.0);
	CreateDynamicPickup(1239, 1, -636.5583,1446.6155,13.9965, 0, 0, -1);

	CreateDynamic3DTextLabel(""STRING_YELLOW"[ KUPNJA / PRODAJA ]\n"STRING_WHITE"da vidite opcije ukucajte "STRING_YELLOW"/blackmarket", COLOR_YELLOW, -657.9172,1447.0024,13.6172, 15.0);
	CreateDynamicPickup(1313, 1, -657.9172,1447.0024,13.6172, 0, 0, -1);
	//Farmer
	posijano = 0;
	zauzeto = 0;
	CreatePickup(1239, 1, 295.9053,1129.8921,9.4619, 0);
	Create3DTextLabel(""STRING_GREEN"[FARMER]\n"STRING_WHITE"Da se zaposlite \nukucajte "STRING_GREEN"/takejob", -1, 295.9053,1129.8921,9.4619, 50.0, 0, 1);

	CreatePickup(1274,1,311.7521,1129.3335,9.4497,0);
	Create3DTextLabel("Da krenete raditi rutu\nukucajte "STRING_YELLOW"/work", -1, 311.7521,1129.3335,9.4497, 50.0, 0, 1);

	Create3DTextLabel("Da krenete musti kravu\nukucajte "STRING_YELLOW"/muznja", -1, 315.36346, 1172.10803, 9.65489, 30.0, 0, 0);
	Create3DTextLabel("Da krenete musti kravu\nukucajte "STRING_YELLOW"/muznja", -1, 303.90872, 1172.70435, 9.97057, 30.0, 0, 0);
	Create3DTextLabel("Da krenete musti kravu\nukucajte "STRING_YELLOW"/muznja", -1, 292.97778, 1173.30396, 10.61319, 30.0, 0, 0);

	//Army
	CreatePickup(1314, 1, 156.1201,1439.9026,11.1314, 0);
	Create3DTextLabel("[CARSON ARMY]\n"STRING_WHITE"Pritisnite"STRING_YELLOW"F"STRING_WHITE" da udjete", COLOR_YELLOW, 156.1201,1439.9026,11.1314, 40.0, 0, 1);
	CreatePickup(1318, 1, 232.4430,1822.4905,7.4141, 2500);

	CreatePickup(1239, 1, 213.2150,1819.8434,6.4216, 2500);
	Create3DTextLabel("[TREZOR]\nPritisnite "STRING_RED"F"STRING_WHITE" da otvorite", -1, 213.2150,1819.8434,6.4216, 15.0, 2500, 1);

	CreatePickup(1254, 1, 212.4152,1822.9064,6.4141, 2500);
	Create3DTextLabel("Ukucajte "STRING_RED"/mission"STRING_WHITE" da\nvidite dostupne misije.", -1, 212.4152,1822.9064,6.4141, 15.0, 2500, 1);
	//
	for(new as = 0; as < 9; as++)
	{
	as3D[as] = Create3DTextLabel("[AUTO-SALON]", COLOR_DGOLD, 0.0, 0.0, 0.0, 50.0, 0, 1);
	as3Dadd[as] = Attach3DTextLabelToVehicle(as3D[as], asCar[as], 0, 0, 0);
	}
//Ucitava AUTO-SALON
CreatePickup(1239, 1, -311.1066,1303.3275,53.6643, 0);
Create3DTextLabel(""STRING_WHITE"[ AUTO-SALON ]"STRING_GREEN"\nDa udjete pritisnite "STRING_WHITE"'F'", COLOR_GREEN, -311.1066,1303.3275,53.6643, 40.0, 0, 1);
//
for(new ipd = 0; ipd < 10; ipd++)
{
	new oFile[80];
	format(oFile,sizeof(oFile),DrogaPath, ipd);
	if(fexist(oFile))
	{
		INI_ParseFile(oFile, "UcitajDrogaInfo", .bExtra = true, .extra = ipd);
		CitajDrogu(ipd);
		print("| Droga ucitana.");
	}
}
for(new ipx = 0; ipx < MAX_HOUSE; ipx++)
{
	new oFile[80];
	format(oFile,sizeof(oFile),KucaPath, ipx);
	if(fexist(oFile))
	{
		INI_ParseFile(oFile, "UcitajKucaInfo", .bExtra = true, .extra = ipx);
		CitajKucu(ipx);
		print("Kuce su uspjesno ucitane.");
	}
}
/////////////////////////////////////////////////////
for(new ipy = 0; ipy < MAX_BUSINESS; ipy++)
{
	new oFile[80];
	format(oFile,sizeof(oFile),BiznisPath, ipy);
	if(fexist(oFile))
	{
		INI_ParseFile(oFile, "UcitajBiznisInfo", .bExtra = true, .extra = ipy);
		CitajBiznis(ipy);
		print("Biznis je uspjesno ucitan.");
	}
}
/////////////////////////////////////////////////////
for(new ips = 1; ips < MAX_VEHICLE; ips++)
{
	new vFile[80];
	format(vFile,sizeof(vFile), VehiclePath, ips);
	if(fexist(vFile))
	{
		INI_ParseFile(vFile, "UcitajVehicleInfo", .bExtra = true, .extra = ips);
		CitajVehicle(ips);
		print("Vozilo ucitano.");
	}
}
//---------- MAPA: DODAJ OBJEKTE --------------------------------------------//
//SADNJA DROGE #1
CreateDynamicObject(3276,-1662.4574000,2541.0773900,85.1237600,0.0000000,0.0000000,-1.7400000); //
CreateDynamicObject(3276,-1660.4543500,2560.8549800,84.7790600,0.0000000,0.0000000,0.2400000); //
CreateDynamicObject(3276,-1655.4377400,2555.6840800,84.7703600,0.0000000,0.0000000,87.0000000); //
CreateDynamicObject(3250,-1675.5793500,2563.1025400,84.2169400,0.0000000,0.0000000,94.3200100); //
drogaObject[1] = CreateDynamicObject(759,-1658.3095700,2543.5437000,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[2] = CreateDynamicObject(759,-1664.1262200,2543.7490200,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[3] = CreateDynamicObject(759,-1669.6272000,2544.5065900,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[4] = CreateDynamicObject(759,-1658.3775600,2549.1289100,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[5] = CreateDynamicObject(759,-1664.0459000,2549.3376500,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[6] = CreateDynamicObject(759,-1669.8579100,2549.6899400,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[7] = CreateDynamicObject(759,-1669.6163300,2555.0568800,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[8] = CreateDynamicObject(759,-1664.1549100,2555.0839800,84.1898600,0.0000000,0.0000000,42.3600000); //
drogaObject[9] = CreateDynamicObject(759,-1658.5105000,2554.8632800,84.1898600,0.0000000,0.0000000,42.3600000); //
//NOVA POLICIJA
tmpobjid = CreateDynamicObject(16563, -155.926422, 1072.471069, 17.402099, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1361, -150.570220, 1084.268188, 19.387559, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1361, -150.570205, 1078.808471, 19.387599, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(700, -150.814468, 1075.730468, 18.730009, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(700, -150.766815, 1077.533081, 18.730009, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(700, -150.858978, 1085.610839, 18.730009, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(700, -150.883132, 1087.191040, 18.730009, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1308, -153.074996, 1088.269409, 21.054830, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1308, -156.205902, 1088.269409, 21.054800, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1364, -164.633239, 1085.682983, 19.493900, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1364, -164.633193, 1080.869140, 19.493900, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1280, -161.423141, 1075.539550, 19.118410, 0.000000, 0.000000, -89.280006, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(862, -152.334197, 1077.037719, 18.716100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(862, -152.330276, 1077.834228, 18.716100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(862, -152.302856, 1078.716674, 18.716100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

//SPAWN SLIKA
CreateDynamicObject(16105,-616.6338500,2714.0158700,73.3078300,356.8584000,0.0000000,99.0240300); //
CreateDynamicObject(11490,-637.7002600,2705.0852100,71.2129200,0.0000000,0.0000000,1.9200000); //
CreateDynamicObject(11491,-637.3914200,2694.1494100,72.6512000,0.0000000,0.0000000,1.9200000); //
CreateDynamicObject(1516,-640.2994400,2693.8791500,72.8073200,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(2096,-639.5684200,2694.9228500,72.6341000,0.0000000,0.0000000,-29.3400000); //
CreateDynamicObject(19823,-640.0236200,2693.8120100,73.3324900,0.0000000,0.0000000,135.7799800); //
CreateDynamicObject(19818,-640.2022700,2693.9438500,73.4131400,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19897,-640.0023200,2694.1794400,73.3723100,0.1800000,0.0000000,0.0000000); //
CreateDynamicObject(1665,-639.8596200,2694.3530300,73.3460000,0.0000000,0.0000000,-196.6200900); //
//DRUGI Grad
CreateDynamicObject(16781,-835.0120800,1625.6417200,25.9019300,0.0000000,0.0000000,0.0599700); //
CreateDynamicObject(3356,-904.6022300,1551.7353500,29.0072600,0.0000000,0.0000000,-273.8400900); //
CreateDynamicObject(19367,-798.4953600,1562.0135500,26.0403300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-796.8527200,1560.2799100,26.0403000,0.0000000,0.0000000,82.0754200); //
CreateDynamicObject(19367,-798.4954200,1565.2058100,26.0403000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-798.5026200,1568.3861100,26.0403000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-797.3253200,1570.9908400,26.0403000,0.0000000,0.0000000,311.4784500); //
CreateDynamicObject(19367,-794.5760500,1572.0214800,26.0403000,0.0000000,0.0000000,89.6354700); //
CreateDynamicObject(19367,-791.3891000,1572.0135500,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(11437,-786.9092400,1565.4257800,25.6283600,0.0000000,0.0000000,89.8800000); //
CreateDynamicObject(19367,-785.8286700,1572.0307600,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-782.6198100,1572.0296600,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-779.4658800,1572.0300300,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-776.3441200,1572.0300300,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-773.1643100,1572.0300300,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-770.0244800,1572.0300300,26.0403000,0.0000000,0.0000000,90.0000000); //
CreateDynamicObject(19367,-767.3177500,1570.9530000,26.0403000,0.0000000,0.0000000,46.5138100); //
CreateDynamicObject(19367,-764.9959700,1568.7459700,26.0403000,0.0000000,0.0000000,46.5138100); //
CreateDynamicObject(19367,-763.7644700,1566.0911900,26.0403000,0.0000000,0.0000000,183.4938200); //
CreateDynamicObject(19367,-763.6192600,1562.9039300,26.0403000,0.0000000,0.0000000,1.8600000); //
CreateDynamicObject(19367,-763.5974700,1559.7209500,26.0403000,0.0000000,0.0000000,-1.0200000); //
CreateDynamicObject(19367,-763.6538100,1556.5157500,26.0403000,0.0000000,0.0000000,-1.0200000); //
CreateDynamicObject(19367,-763.6627200,1553.3378900,26.0403000,0.0000000,0.0000000,0.8400000); //
CreateDynamicObject(19367,-763.6193200,1550.1564900,26.0403000,0.0000000,0.0000000,0.8400000); //
CreateDynamicObject(19367,-764.7628800,1547.5478500,26.0403000,0.0000000,0.0000000,-48.1800500); //
CreateDynamicObject(19367,-767.1340300,1545.4277300,26.0403000,0.0000000,0.0000000,-48.1800500); //
CreateDynamicObject(19367,-769.5048800,1543.3048100,26.0403000,0.0000000,0.0000000,-48.1800500); //
CreateDynamicObject(19367,-772.2457900,1542.2288800,26.0403000,0.0000000,0.0000000,91.0199800); //
CreateDynamicObject(19367,-775.4254800,1542.2128900,26.0403000,0.0000000,0.0000000,89.7000000); //
CreateDynamicObject(19367,-778.6270100,1542.2230200,26.0403000,0.0000000,0.0000000,89.7599900); //
CreateDynamicObject(19367,-781.8309900,1542.2299800,26.0403000,0.0000000,0.0000000,89.9400000); //
CreateDynamicObject(19367,-785.0131200,1542.2316900,26.0403000,0.0000000,0.0000000,89.9400000); //
CreateDynamicObject(19367,-796.9417700,1542.2030000,26.0403000,0.0000000,0.0000000,89.9400000); //
CreateDynamicObject(19367,-793.7813700,1542.1940900,26.0403000,0.0000000,0.0000000,89.9400000); //
CreateDynamicObject(19367,-790.5944800,1542.1886000,26.0403000,0.0000000,0.0000000,89.9400000); //
CreateDynamicObject(11437,-786.1343400,1535.5267300,25.6155800,0.0000000,0.0000000,89.8800000); //
CreateDynamicObject(19367,-796.9600200,1553.7596400,26.0403000,0.0000000,0.0000000,91.2554300); //
CreateDynamicObject(19367,-798.4754000,1552.1973900,26.0403300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-798.4727800,1549.0722700,26.0403300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-798.4719800,1545.8916000,26.0403000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(19367,-798.4708900,1543.7099600,26.0403000,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(617,-766.9612400,1571.1392800,25.3549700,0.0000000,0.0000000,73.0199800); //
CreateDynamicObject(617,-764.3639500,1568.2907700,25.3549700,0.0000000,0.0000000,14.8200000); //
CreateDynamicObject(1280,-766.6595500,1545.1031500,26.3474300,0.0000000,0.0000000,132.0600600); //
CreateDynamicObject(1264,-765.1546000,1546.5820300,25.9969100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(1264,-764.6726100,1547.0322300,25.8701400,0.0000000,0.0000000,-119.3399900); //
CreateDynamicObject(973,-786.8369800,1546.2601300,26.0184200,0.0000000,0.0000000,62.1600300); //
CreateDynamicObject(973,-784.2684900,1546.3768300,26.0184200,0.0000000,0.0000000,62.1600300); //
CreateDynamicObject(973,-782.4507400,1554.5416300,26.0184200,0.0000000,0.0000000,62.1600300); //
CreateDynamicObject(973,-778.2121000,1557.7961400,26.0184200,0.0000000,0.0000000,62.1600300); //
CreateDynamicObject(973,-777.9622800,1548.6637000,26.0184200,0.0000000,0.0000000,154.9801000); //
CreateDynamicObject(973,-776.2349900,1551.8907500,26.0184200,0.0000000,0.0000000,154.9801000); //
CreateDynamicObject(973,-767.9669800,1551.5301500,26.0184200,0.0000000,0.0000000,20.8800200); //
CreateDynamicObject(973,-767.9669800,1551.5301500,26.0184200,0.0000000,0.0000000,20.8800200); //
CreateDynamicObject(973,-772.7119100,1546.2039800,26.0184200,0.0000000,0.0000000,154.9801000); //
CreateDynamicObject(973,-786.9891400,1568.2984600,25.9928100,0.0000000,0.0000000,125.8801000); //
CreateDynamicObject(973,-782.9414700,1562.5317400,25.9928100,0.0000000,0.0000000,123.7800800); //
CreateDynamicObject(973,-784.4501300,1568.2911400,26.0184200,0.0000000,0.0000000,126.4802100); //
CreateDynamicObject(973,-777.5612800,1562.7319300,26.0184200,0.0000000,0.0000000,156.4202100); //
CreateDynamicObject(673,-773.3684700,1560.7930900,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-780.5388800,1558.7081300,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-780.3587000,1553.8031000,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-782.2677000,1550.4902300,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-776.2163700,1561.8325200,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-781.7599500,1564.5620100,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(673,-772.0410800,1549.9655800,23.0679300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(647,-781.3056000,1547.7629400,26.0838800,0.0000000,0.0000000,-32.8800100); //
CreateDynamicObject(647,-783.1038800,1545.0317400,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-780.3245200,1544.8012700,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-779.1002200,1546.7636700,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-777.7915600,1544.5557900,26.0838800,0.0000000,0.0000000,4.0799900); //
CreateDynamicObject(647,-776.8770100,1546.1051000,26.0838800,0.0000000,0.0000000,-121.6799900); //
CreateDynamicObject(647,-774.5419300,1545.2718500,26.0838800,0.0000000,0.0000000,-111.5999900); //
CreateDynamicObject(831,-771.8534500,1543.8996600,25.9987400,0.0000000,0.0000000,-26.1000000); //
CreateDynamicObject(831,-775.7599500,1544.1650400,25.9987400,0.0000000,0.0000000,31.0200300); //
CreateDynamicObject(813,-766.5723900,1554.9481200,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-772.2825300,1553.2375500,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-767.0393100,1560.9456800,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-772.0669600,1567.9788800,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-766.6623500,1565.9602100,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-774.2173500,1557.9997600,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-772.6080300,1563.9979200,27.7678900,0.0000000,0.0000000,-22.8000000); //
CreateDynamicObject(813,-778.7090500,1567.6217000,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-786.8917800,1562.9567900,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-778.7090500,1567.6217000,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-795.9056400,1563.7182600,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-789.4105200,1566.4364000,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-793.5662200,1569.3015100,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(647,-774.8311200,1569.0014600,27.2076800,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(647,-775.5286300,1565.0465100,27.2076800,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(647,-780.9142500,1568.8035900,27.2076800,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(647,-790.3824500,1563.1403800,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-780.9142500,1568.8035900,27.2076800,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(647,-793.1953700,1565.6832300,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-769.6773700,1559.6695600,27.2076800,0.0000000,0.0000000,0.1200000); //
CreateDynamicObject(647,-769.2924200,1568.4270000,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(835,-771.6413000,1556.2221700,28.5056300,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(833,-770.1705900,1564.6604000,26.7499100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(831,-766.2193600,1558.9707000,25.9987400,0.0000000,0.0000000,-109.5599700); //
CreateDynamicObject(831,-773.4208400,1562.9290800,25.9987400,0.0000000,0.0000000,-41.4599800); //
CreateDynamicObject(837,-767.2478600,1563.8356900,26.3358500,0.0000000,0.0000000,95.8200000); //
CreateDynamicObject(813,-781.7363900,1558.8437500,27.7678900,0.0000000,0.0000000,63.6600000); //
CreateDynamicObject(831,-790.8034700,1569.3418000,26.5378600,0.0000000,0.0000000,-29.9400000); //
CreateDynamicObject(837,-797.4733300,1564.5015900,26.2205700,0.0000000,0.0000000,82.9800100); //
CreateDynamicObject(647,-795.4760700,1545.5732400,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-791.4250500,1549.7916300,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-786.8347800,1551.4637500,26.0838800,0.0000000,0.0000000,-5.8800100); //
CreateDynamicObject(647,-790.8493000,1545.2932100,26.0838800,0.0000000,0.0000000,95.2199900); //
CreateDynamicObject(831,-787.9277300,1547.4272500,25.9987400,0.0000000,0.0000000,31.0200300); //
CreateDynamicObject(813,-795.3142700,1548.5046400,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-792.7674000,1546.3137200,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(813,-789.0109300,1551.7265600,27.7678900,0.0000000,0.0000000,-22.9200000); //
CreateDynamicObject(831,-790.9021000,1552.3076200,25.9987400,0.0000000,0.0000000,31.0200300); //
CreateDynamicObject(1280,-770.3474100,1550.2584200,26.4269300,0.0000000,0.0000000,112.3801100); //
CreateDynamicObject(1280,-767.2258900,1551.5019500,26.3758900,0.0000000,0.0000000,112.3801100); //
CreateDynamicObject(1280,-765.5117200,1547.5094000,26.2708000,0.0000000,0.0000000,312.5402500); //
CreateDynamicObject(649,-854.6494800,1546.3801300,21.6427900,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(649,-855.4495800,1564.2979700,21.6427900,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(649,-852.3894000,1564.2522000,21.6427900,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(649,-851.2263200,1563.7517100,21.6427900,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(649,-850.3754900,1546.7122800,21.6427900,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(12963,-823.7428000,1574.3424100,30.5562700,0.0000000,0.0000000,179.9399300); //
CreateDynamicObject(896,-831.3875100,1590.6489300,19.7366400,0.7200000,-2.4600000,-85.6799900); //
CreateDynamicObject(896,-832.2999300,1583.2263200,19.7366400,0.7200000,-2.4600000,-67.9199800); //
CreateDynamicObject(896,-831.9040500,1577.4439700,19.7366400,0.7200000,-2.4600000,-67.9199800); //
CreateDynamicObject(896,-831.2589700,1567.0938700,19.7366400,0.7200000,-2.4600000,2.1600200); //
CreateDynamicObject(896,-831.9912100,1563.8845200,19.7366400,0.7200000,-2.4600000,-9.1799900); //
CreateDynamicObject(896,-829.8111600,1561.7623300,19.6380400,0.7200000,-2.4600000,68.5800100); //
CreateDynamicObject(752,-833.2072100,1560.4163800,23.5091200,0.0000000,0.0000000,-71.0999900); //
CreateDynamicObject(752,-833.3895900,1558.9458000,23.5091200,0.0000000,0.0000000,-72.9599600); //
CreateDynamicObject(12982,-791.8855000,1595.4323700,30.4364100,0.0000000,0.0000000,180.2399100); //
CreateDynamicObject(19366,-798.9694200,1604.2050800,26.0519900,0.0000000,86.8833000,0.0000000); //
CreateDynamicObject(19366,-801.7971800,1604.2000700,25.9369000,0.0000000,88.2685000,0.0000000); //
CreateDynamicObject(19366,-799.0692700,1592.6444100,26.0519900,0.0000000,86.8833000,0.0000000); //
CreateDynamicObject(19366,-801.7973000,1592.6591800,25.9369000,0.0000000,88.2685000,0.0000000); //
CreateDynamicObject(19366,-820.3006000,1587.7117900,26.0520000,0.0000000,90.6926000,0.0000000); //
CreateDynamicObject(19366,-820.3059100,1580.4100300,26.0520000,0.0000000,90.6926000,0.0000000); //
CreateDynamicObject(19366,-820.3065200,1568.6275600,26.0520000,0.0000000,90.6926000,0.0000000); //
CreateDynamicObject(19366,-820.3273900,1561.3447300,26.0520000,0.0000000,90.6926000,0.0000000); //
CreateDynamicObject(3640,-823.8509500,1603.5427200,30.2633900,0.0000000,0.0000000,90.1200300); //
CreateDynamicObject(19366,-817.8320300,1602.0385700,26.0520000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-817.8333100,1605.2310800,26.0520000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-815.2952900,1602.0263700,26.0520000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-815.2830200,1605.2376700,26.0520000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(19366,-821.3241000,1605.2301000,26.0520000,0.0000000,90.0000000,0.0000000); //
CreateDynamicObject(652,-729.4142500,1611.4265100,25.6996600,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(652,-745.3115800,1612.8610800,25.8593800,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(652,-736.1819500,1648.2409700,23.5307200,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(652,-718.8658400,1630.3975800,21.1772600,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(652,-771.5348500,1648.1182900,23.5307200,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(652,-783.4260300,1639.0523700,23.5307200,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(647,-729.0063500,1611.5344200,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-736.3479600,1612.0775100,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-744.8894700,1613.2867400,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-752.7747800,1614.6285400,27.2076800,0.0000000,0.0000000,-0.1800000); //
CreateDynamicObject(647,-747.1315300,1613.6446500,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-750.0394300,1614.2567100,27.2076800,0.0000000,0.0000000,-0.1800000); //
CreateDynamicObject(647,-741.6615600,1613.1033900,27.2076800,0.0000000,0.0000000,-0.1800000); //
CreateDynamicObject(647,-731.4058800,1611.7337600,27.2076800,0.0000000,0.0000000,4.8000000); //
CreateDynamicObject(647,-733.5153800,1611.9632600,27.2076800,0.0000000,0.0000000,4.8000000); //
CreateDynamicObject(647,-738.8844600,1612.6333000,27.2076800,0.0000000,0.0000000,4.8000000); //
CreateDynamicObject(647,-721.5827000,1611.2902800,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-723.7686200,1611.3704800,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(647,-726.2459100,1611.2028800,27.2076800,0.0000000,0.0000000,-0.0600000); //
CreateDynamicObject(3172,-741.9111900,1646.9013700,26.2760600,0.0000000,0.0000000,90.2399800); //
CreateDynamicObject(1308,-756.3634600,1595.5835000,29.8423600,0.0000000,180.0000000,0.0000000); //
CreateDynamicObject(1308,-761.0619500,1585.6195100,29.8423600,0.0000000,180.0000000,0.0000000); //
CreateDynamicObject(1308,-754.4116200,1581.2672100,29.8423600,0.0000000,180.0000000,0.0000000); //
CreateDynamicObject(1308,-739.7890000,1579.6229200,29.8423600,0.0000000,180.0000000,0.0000000); //
CreateDynamicObject(754,-753.9531300,1575.4062500,26.1640600,356.8584000,0.0000000,-2.0943900); //
CreateDynamicObject(700,-760.3866600,1588.1732200,25.5387300,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(700,-758.2813700,1592.9064900,25.5387300,356.8584000,0.0000000,3.1415900); //
CreateDynamicObject(700,-754.0913100,1594.9664300,25.5387300,356.8584000,0.0000000,24.1415800); //
CreateDynamicObject(700,-750.6615600,1593.2041000,25.5387300,356.8584000,0.0000000,24.1415800); //
CreateDynamicObject(700,-742.6897600,1585.0212400,25.5387300,356.8584000,0.0000000,-5.3184100); //
CreateDynamicObject(700,-740.8240400,1582.0775100,25.5387300,356.8584000,0.0000000,-5.3184100); //
CreateDynamicObject(3648,-780.5035400,1521.9497100,28.7292100,0.0000000,0.0000000,270.1199600); //
CreateDynamicObject(3555,-793.7260700,1520.5758100,28.3153100,0.0000000,0.0000000,0.0000000); //
CreateDynamicObject(3646,-824.5316200,1549.4757100,28.3257400,0.0000000,0.0000000,-178.7998800); //
CreateDynamicObject(3646,-905.7102100,1535.6751700,27.1946300,0.0000000,0.0000000,173.8199500); //
//BLACKSMITH
CreateDynamicObject(19458, -939.8176, 1423.3688, 29.0957, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19458, -936.3904, 1423.3688, 29.0957, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19458, -933.0000, 1423.3688, 29.0957, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19458, -941.5029, 1423.3688, 30.8433, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19458, -936.7873, 1418.6404, 30.8433, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(19458, -936.7712, 1428.0980, 30.8433, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(19366, -932.0626, 1420.2063, 30.8433, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19366, -932.0516, 1426.5485, 30.8433, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19386, -932.0516, 1423.3730, 30.8433, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19458, -939.8176, 1423.3688, 32.5339, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19458, -936.3904, 1423.3688, 32.5339, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19458, -933.0000, 1423.3688, 32.5339, 0.0000, 90.0000, 0.0000);
CreateDynamicObject(19366, -938.3509, 1420.1173, 30.8433, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19386, -939.9461, 1421.6367, 30.8433, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(2912, -941.0920, 1427.6799, 29.1790, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2912, -941.0969, 1427.0095, 29.1790, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2912, -941.0920, 1427.6799, 29.8717, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3052, -938.8774, 1419.0017, 29.2972, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3052, -938.6522, 1421.1403, 29.2972, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3015, -941.0718, 1419.0547, 29.2844, 0.0000, 0.0000, 29.6400);
CreateDynamicObject(3015, -940.4908, 1419.1257, 29.2844, 0.0000, 0.0000, -12.4200);
CreateDynamicObject(3015, -941.0820, 1419.6953, 29.2844, 0.0000, 0.0000, 3.9600);
CreateDynamicObject(1271, -938.8438, 1419.9480, 29.5038, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19815, -932.1354, 1420.0677, 30.6878, 0.0000, 0.0000, -90.0000);
CreateDynamicObject(2912, -940.3923, 1427.6728, 29.1790, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2912, -938.5149, 1427.6777, 29.1790, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2912, -937.8205, 1427.6791, 29.1790, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(917, -937.8701, 1427.6506, 30.0064, 0.0000, 0.0000, 22.8600);
CreateDynamicObject(19815, -937.3500, 1428.0100, 30.7903, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3927, -924.9763, 1427.6031, 31.2200, 0.0000, 0.0000, 88.0800);
CreateDynamicObject(617, -932.3828, 1429.7405, 28.5730, 0.0000, 0.0000, -4.8600);
CreateDynamicObject(617, -943.6804, 1417.3554, 28.3558, 0.0000, 0.0000, 24.9000);
CreateDynamicObject(1255, -934.5886, 1429.1997, 29.6239, 0.0000, 0.0000, 89.9400);
CreateDynamicObject(1811, -930.7031, 1426.7976, 29.5976, 0.0000, 0.0000, 226.9199);
CreateDynamicObject(1811, -931.0692, 1429.0807, 29.5976, 0.0000, 0.0000, 484.2600);
CreateDynamicObject(1463, -932.1867, 1417.9929, 29.0983, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1463, -934.1703, 1417.8861, 29.0983, 0.0000, 0.0000, 2.4000);
CreateDynamicObject(917, -931.6220, 1421.3064, 29.3180, 0.0000, 0.0000, 46.9200);
CreateDynamicObject(2204, -933.9296, 1418.7098, 29.0440, 0.0000, 0.0000, -180.0000);
CreateDynamicObject(917, -936.0569, 1418.9822, 29.9351, 0.0000, 0.0000, 18.4800);
CreateDynamicObject(3052, -935.1436, 1418.8118, 30.1979, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3052, -935.1794, 1419.0098, 29.9270, 0.0000, 0.0000, -4.5000);
CreateDynamicObject(846, -939.3732, 1427.2638, 24.7335, 90.0000, 0.0000, 0.0000);
CreateDynamicObject(19843, -935.1255, 1427.5619, 29.7091, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19843, -934.1446, 1427.5598, 29.7091, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19303, -934.6532, 1427.1258, 28.5025, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(19303, -935.4771, 1427.9982, 28.5025, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(19303, -933.8031, 1427.9630, 28.5025, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(19632, -935.1882, 1427.5258, 29.1696, 0.0000, 0.0000, 93.1200);
CreateDynamicObject(19632, -934.7189, 1427.7683, 29.1749, 0.0000, 0.0000, 24.7800);
CreateDynamicObject(19632, -934.4260, 1427.4956, 29.1537, 0.0000, 0.0000, 48.8400);
CreateDynamicObject(19632, -934.0032, 1427.6046, 29.1579, 0.0000, 0.0000, 86.1000);
CreateDynamicObject(19632, -934.8345, 1427.4390, 29.1749, 0.0000, 0.0000, -20.3400);
CreateDynamicObject(19472, -935.7523, 1418.9104, 30.1549, 0.0000, 0.0000, 129.2401);
CreateDynamicObject(19631, -939.9385, 1427.0730, 29.5863, 61.3200, 130.9200, -51.0600);
CreateDynamicObject(18635, -938.5753, 1427.4670, 29.9894, 0.0000, 90.0000, 131.2200);

// KRAVE //
CreateObject(3276, 321.17267, 1172.34961, 8.63630,   0.00000, 0.00000, 86.28003);
CreateObject(3276, 315.98901, 1178.27271, 8.95317,   0.00000, 4.50190, -3.66000);
CreateObject(3276, 309.91608, 1173.24072, 9.01627,   0.00000, 0.00000, 86.28003);
CreateObject(3276, 304.61050, 1179.06543, 9.59726,   0.00000, 2.07780, -3.66000);
CreateObject(3276, 298.75421, 1174.00500, 9.68810,   0.00000, -0.69260, 86.28000);
CreateObject(3276, 293.43893, 1179.72351, 10.06540,   0.00000, 3.11670, -3.66000);
CreateObject(3276, 287.67191, 1174.86609, 10.20945,   0.00000, -2.77040, 86.28000);
CreateObject(16442, 315.36346, 1172.10803, 9.65489,   0.00000, 0.00000, -88.97997);
CreateObject(16442, 303.90872, 1172.70435, 9.97057,   0.00000, 0.00000, -88.97997);
CreateObject(16442, 292.97778, 1173.30396, 10.61319,   0.00000, 0.00000, -88.97997);
CreateObject(3276, 296.68109, 1168.74329, 9.67199,   0.00000, 3.11670, -3.66000);
CreateObject(3276, 311.35306, 1167.74854, 9.07000,   0.00000, 3.11670, -3.66000);
//FARMER #1 //
zito[1] = CreateObject(818, 263.18665, 1152.49268, 0,   0.00000, 0.00000, -34.62000);
zito[2] = CreateObject(818, 257.65616, 1152.64795, 0,   0.00000, 0.00000, -34.62000);
zito[3] = CreateObject(818, 251.55481, 1152.73364, 0,   0.00000, 0.00000, -34.62000);
zito[4] = CreateObject(818, 245.63452, 1152.74561, 0,   0.00000, 0.00000, -34.62000);
zito[5] = CreateObject(818, 239.31229, 1152.66565, 0,   0.00000, 0.00000, -34.62000);
zito[6] = CreateObject(818, 233.61259, 1152.73572, 0,   0.00000, 0.00000, -34.62000);
zito[7] = CreateObject(818, 227.75075, 1152.76831, 0,   0.00000, 0.00000, -34.62000);
zito[8] = CreateObject(818, 263.09848, 1140.21887, 0,   0.00000, 0.00000, -34.62000);
zito[9] = CreateObject(818, 257.38342, 1140.08008, 0,   0.00000, 0.00000, -34.62000);
zito[10] = CreateObject(818, 250.83134, 1140.37573, 0,   0.00000, 0.00000, -34.62000);
zito[11] = CreateObject(818, 244.98587, 1140.63721, 0,   0.00000, 0.00000, -34.62000);
zito[12] = CreateObject(818, 238.96049, 1140.59009, 0,   0.00000, 0.00000, -34.62000);
zito[13] = CreateObject(818, 233.06183, 1140.54419, 0,   0.00000, 0.00000, -34.62000);
zito[14] = CreateObject(818, 226.64233, 1140.86646, 0,   0.00000, 0.00000, -34.62000);
zito[15] = CreateObject(818, 263.41553, 1125.63928, 0,   0.00000, 0.00000, -34.62000);
zito[16] = CreateObject(818, 257.07257, 1126.09131, 0,   0.00000, 0.00000, -34.62000);
zito[17] = CreateObject(818, 250.30775, 1125.92224, 0,   0.00000, 0.00000, -34.62000);
zito[18] = CreateObject(818, 244.39594, 1126.00854, 0,   0.00000, 0.00000, -34.62000);
zito[19] = CreateObject(818, 238.81793, 1125.90967, 0,   0.00000, 0.00000, -34.62000);
zito[20] = CreateObject(818, 232.89105, 1125.87305, 0,   0.00000, 0.00000, -34.62000);
zito[21] = CreateObject(818, 226.41110, 1126.05615, 0,   0.00000, 0.00000, -34.62000);
//AUTO-SALON //
CreateObject(669, -308.74316, 1331.19275, 52.07337,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -331.82800, 1306.65759, 51.03080,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -322.26431, 1306.65759, 51.03080,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -316.45889, 1306.65759, 51.05900,   0.00000, 0.00000, 90.34630);

//UNUTRASNJOST AUTOSALONA
CreateObject(14855, 352.88287, 161.83255, 1023.65448,   0.00000, 0.00000, -89.93999);
CreateObject(1522, 353.45868, 158.74890, 1024.73438,   0.00000, 0.00000, 0.60000);

//PRIVATNA SOBA NOCNOG KLUBA//
CreateObject(18018, -310.87708, 821.88629, -34.63775,   0.00000, 0.00000, 0.00000);
CreateObject(18102, -319.56506, 811.50684, -29.23090,   0.00000, 0.00000, 77.16002);
CreateObject(19377, -317.87686, 810.42023, -34.56365,   0.00000, 0.00000, 0.18000);
CreateObject(1823, -320.97955, 814.03558, -34.66997,   0.00000, 0.00000, -0.30000);
CreateObject(2125, -321.67215, 814.50067, -34.34303,   0.00000, 0.00000, 0.00000);
CreateObject(2125, -320.45966, 813.47278, -34.36200,   0.00000, 0.00000, 0.00000);
CreateObject(2125, -319.29053, 814.48615, -34.35900,   0.00000, 0.00000, 0.00000);
CreateObject(1520, -320.91345, 814.77942, -34.13476,   0.00000, 0.00000, 27.60000);
CreateObject(1520, -319.99768, 814.59326, -34.13476,   0.00000, 0.00000, 100.08001);
CreateObject(1520, -320.34561, 814.19604, -34.13476,   0.00000, 0.00000, 100.08001);
CreateObject(14866, -323.63748, 811.30585, -34.09381,   0.00000, 0.00000, 90.00000);
CreateObject(1735, -318.84415, 808.66187, -34.64238,   0.00000, 0.00000, -122.10001);
CreateObject(2232, -324.19717, 808.65729, -34.08076,   0.00000, 0.00000, 141.84021);
CreateObject(2596, -318.23434, 811.30249, -31.35989,   0.00000, 0.00000, -91.68002);
CreateObject(2778, -324.33521, 814.60901, -34.69328,   0.00000, 0.00000, 0.00000);
CreateObject(2670, -319.65543, 812.68365, -34.55508,   0.00000, 0.00000, 0.00000);
CreateObject(2670, -320.35532, 810.84216, -34.55508,   0.00000, 0.00000, 248.87997);
CreateObject(2670, -324.04462, 813.65973, -34.55508,   0.00000, 0.00000, 358.07990);
CreateObject(2670, -320.47330, 808.38037, -34.55508,   0.00000, 0.00000, 502.08054);
CreateObject(1522, -317.90167, 810.80310, -34.73459,   0.00000, 0.00000, 90.29998);
//___________________________||
CreateObject(19363, 681.27618, -450.48071, -25.09860,   0.00000, 0.00000, 90.00000);
CreateObject(19363, 681.27618, -450.48071, -21.60035,   0.00000, 0.00000, 90.00000);
CreateObject(1522, 680.65302, -450.51120, -26.67349,   0.00000, 0.00000, 0.00000);


CreateObject(3258, 288.19690, 1420.80615, 25.20117,   180.00000, 0.00000, 0.00000);
CreateObject(3258, 288.21249, 1401.44592, 25.20117,   180.00000, 0.00000, 0.00000);
CreateObject(1308, 288.23251, 1421.65820, 23.85805,   90.00000, 0.00000, 0.00000);
CreateObject(1308, 288.21689, 1401.76599, 23.85800,   -90.00000, 0.00000, 0.00000);
CreateObject(5309, 125.17136, 1391.75757, 12.82057,   0.00000, 0.00000, 90.00000);
CreateObject(4021, 143.59282, 1078.27917, 18.84200,   0.00000, 0.00000, 246.83987);
CreateObject(982, 134.73436, 1058.06714, 13.21948,   0.00000, 0.00000, -8.28000);
CreateObject(983, 132.40121, 1042.24634, 13.28478,   0.00000, 0.00000, -8.52000);
CreateObject(982, 119.11953, 1039.51306, 13.21948,   0.00000, 0.00000, 88.25998);
CreateObject(984, 99.94050, 1039.96533, 13.19659,   0.00000, 0.00000, 89.22000);
CreateObject(983, 90.35241, 1040.04053, 13.24148,   0.00000, 0.00000, 90.60008);
CreateObject(982, 86.21897, 1052.75891, 13.21948,   0.00000, 0.00000, 184.31995);
CreateObject(982, 83.31066, 1078.16064, 13.21948,   0.00000, 0.00000, 188.75995);
CreateObject(983, 84.12077, 1071.72583, 12.88010,   0.00000, 0.00000, 0.00000);
CreateObject(983, 84.28500, 1092.05115, 13.15675,   0.00000, 0.00000, -67.02000);
CreateObject(983, 90.43206, 1093.40222, 13.15675,   0.00000, 0.00000, -87.72001);
CreateObject(983, 96.07664, 1095.61279, 13.15675,   0.00000, 0.00000, -49.86002);
CreateObject(984, 98.53394, 1104.07397, 13.14295,   0.00000, 0.00000, -0.42000);
CreateObject(984, 104.93443, 1113.39014, 13.14295,   0.00000, 0.00000, 95.82000);
CreateObject(984, 117.23877, 1114.69678, 13.14295,   0.00000, 0.00000, 96.71999);
CreateObject(983, 121.97102, 1115.23828, 13.20307,   0.00000, 0.00000, 95.88004);
CreateObject(983, 125.68014, 1112.36987, 13.20307,   0.00000, 0.00000, 189.59993);
CreateObject(983, 128.87508, 1107.50781, 13.24351,   0.00000, 0.00000, 236.63995);
CreateObject(982, 144.27231, 1105.18213, 13.21948,   0.00000, 0.00000, 87.11999);
CreateObject(983, 144.38525, 1094.62146, 13.24351,   0.00000, 0.00000, 309.00003);
CreateObject(982, 159.62524, 1097.03564, 13.21948,   0.00000, 0.00000, 91.85998);
CreateObject(984, 98.54658, 1106.29541, 13.14295,   0.00000, 0.00000, -0.42000);
CreateObject(769, 93.43502, 1025.79358, 13.06250,   3.14159, 0.00000, 1.48353);
CreateObject(769, 142.84657, 1018.15240, 13.06250,   3.14159, 0.00000, 1.48353);
CreateObject(870, 97.05839, 1098.41528, 12.74065,   0.00000, 0.00000, 0.00000);
CreateObject(870, 94.94642, 1096.36951, 12.74065,   0.00000, 0.00000, -6.96000);
CreateObject(870, 95.99651, 1097.23425, 12.74065,   0.00000, 0.00000, 0.00000);
CreateObject(870, 93.21341, 1095.13928, 12.74065,   0.00000, 0.00000, -10.86000);
CreateObject(870, 91.67815, 1094.81982, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 89.94253, 1094.88123, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 93.55355, 1097.47815, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 91.69104, 1096.99036, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 95.13442, 1098.83643, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 97.20022, 1100.70276, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 89.82127, 1096.95715, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 88.40882, 1094.90173, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 92.66916, 1099.33813, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 91.03224, 1098.86792, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(870, 94.94601, 1100.86523, 12.74065,   0.00000, 0.00000, -42.36002);
CreateObject(700, 93.65600, 1097.62988, 12.21316,   356.85840, 0.00000, 3.14159);
CreateObject(700, 98.51460, 1112.69922, 12.67117,   356.85840, 0.00000, 3.14159);
CreateObject(700, 124.96425, 1115.75354, 12.67117,   356.85840, 0.00000, 3.14159);
CreateObject(700, 131.30925, 1105.69775, 12.67117,   356.85840, 0.00000, 3.14159);
CreateObject(700, 156.23495, 1096.81152, 14.04754,   356.85840, 0.00000, 3.14159);
CreateObject(700, 155.89998, 1104.73682, 13.78785,   356.85840, 0.00000, 3.14159);
CreateObject(700, 87.13000, 1039.90869, 12.67117,   356.85840, 0.00000, 3.14159);
CreateObject(982, 11.46563, 1160.82520, 19.23732,   0.00000, 0.00000, -89.94000);
CreateObject(983, 27.43288, 1160.83667, 19.23339,   0.00000, 0.00000, 89.81998);






CreateObject(1308, -180.33119, 1088.48962, 22.73059,   180.00000, 0.00000, 0.00000);
CreateObject(948, -180.38631, 1088.45911, 22.58982,   0.00000, 0.00000, 0.00000);




CreateObject(3439, 106.25828, 1069.40369, 16.65006,   0.00000, 0.00000, 0.00000);
CreateObject(746, 107.04247, 1069.55334, 11.42059,   0.00000, 0.00000, -1.50000);
CreateObject(746, 106.27850, 1069.08911, 11.42059,   0.00000, 0.00000, -162.42003);
CreateObject(870, 104.71014, 1070.52527, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 105.31622, 1068.52344, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 107.10728, 1068.52698, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 105.31622, 1068.52344, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 108.09531, 1069.50195, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 107.60886, 1070.92834, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 106.65521, 1071.35425, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 106.65521, 1071.35425, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 104.36779, 1069.01904, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 105.94918, 1067.89294, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(870, 107.57073, 1068.39917, 12.74065,   0.00000, 0.00000, -40.44001);
CreateObject(747, 102.51394, 1070.49121, 11.52661,   0.00000, 0.00000, 158.58006);
CreateObject(747, 102.74126, 1068.84216, 11.52661,   0.00000, 0.00000, 178.73993);
CreateObject(747, 103.96649, 1067.25708, 11.52661,   0.00000, 0.00000, 202.85989);
CreateObject(747, 106.04004, 1066.26282, 11.52661,   0.00000, 0.00000, 255.83997);
CreateObject(747, 107.91223, 1066.48157, 11.52661,   0.00000, 0.00000, 275.75974);
CreateObject(747, 109.56691, 1068.19653, 11.52661,   0.00000, 0.00000, 322.79977);
CreateObject(747, 109.68964, 1070.23010, 11.52661,   0.00000, 0.00000, 345.83997);
CreateObject(747, 109.08529, 1071.64905, 11.52661,   0.00000, 0.00000, 376.14005);
CreateObject(747, 103.63406, 1072.13525, 11.61703,   0.00000, 0.00000, 465.17944);
CreateObject(747, 105.05705, 1072.86633, 11.61703,   0.00000, 0.00000, 460.61957);
CreateObject(747, 107.46384, 1072.74097, 11.61703,   0.00000, 0.00000, 419.09970);
CreateObject(746, 105.25799, 1069.64087, 11.42059,   0.00000, 0.00000, -194.99995);
CreateObject(700, 106.17432, 1069.26904, 12.21316,   356.85840, 0.00000, 3.14159);
CreateObject(700, 131.75163, 1039.05762, 12.21316,   356.85840, 0.00000, 3.14159);
CreateObject(700, 81.35903, 1090.64197, 12.67117,   356.85840, 0.00000, 3.14159);
CreateObject(4027, -27.22398, 1171.30188, 19.25208,   0.00000, 0.00000, -180.29990);
CreateObject(1468, -28.11932, 1162.46716, 19.71880,   356.85840, 0.00000, 0.39840);
CreateObject(1468, -25.53980, 1159.83728, 19.51374,   360.00000, 0.00000, 90.39840);
CreateObject(1468, -25.49110, 1158.12817, 19.52546,   360.00000, 0.00000, 90.39840);
CreateObject(1468, -5.67903, 1159.68213, 19.71875,   356.85840, 0.00000, 90.39842);
CreateObject(982, -42.67800, 1190.78760, 19.01790,   0.00000, 0.00000, 90.00000);
CreateObject(1468, -9.38170, 1188.09839, 19.54640,   360.00000, 0.00000, 90.39840);
CreateObject(1468, -12.01587, 1190.69019, 19.50820,   360.00000, 0.00000, 180.75853);
CreateObject(10832, -49.15023, 1184.04639, 20.03904,   0.00000, 0.00000, 89.70009);
CreateObject(8661, -35.00638, 1178.80933, 18.29985,   0.00000, 0.00000, 0.00000);
CreateObject(4079, 143.22160, 1452.93652, 22.29440,   0.00000, 0.00000, 0.00000);
CreateObject(5309, 197.91631, 1471.37451, 12.82060,   0.00000, 0.00000, 180.00000);
CreateObject(3629, 261.24744, 1367.80896, 15.77812,   0.00000, 0.00000, 0.00000);
CreateObject(3279, 118.39211, 1342.24146, 9.51884,   0.00000, 0.00000, 0.00000);
CreateObject(3279, 282.14624, 1479.89709, 9.55383,   0.00000, 0.00000, -88.43997);
CreateObject(3267, 125.70483, 1431.88721, 34.49679,   0.00000, 0.00000, -87.66000);
CreateObject(3267, 125.19425, 1456.71655, 34.49679,   0.00000, 0.00000, -119.58004);
CreateObject(3267, 138.33218, 1472.24451, 34.49679,   0.00000, 0.00000, -140.10008);
CreateObject(3267, 164.33774, 1471.81226, 34.49679,   0.00000, 0.00000, -175.68011);
CreateObject(4517, -307.82721, -148.69180, 1.95910,   0.00000, 0.00000, 9.18000);
CreateObject(4517, 92.61420, -210.91168, 2.43141,   0.00000, 0.00000, 90.00005);
CreateObject(3169, 311.52890, 1126.94275, 7.92467,   359.31830, -1.74000, 89.58457);
CreateObject(3169, 295.83463, 1127.03699, 7.92467,   359.31830, -1.74000, 89.58457);
CreateObject(3242, 629.81549, 1262.76355, 12.52064,   0.00000, 0.00000, 26.87998);
CreateObject(669, 667.98334, 1216.80750, 9.18110,   3.14159, 0.00000, 0.15708);
CreateObject(669, 671.80029, 1274.56006, 9.18110,   3.14159, 0.00000, 0.15708);
CreateObject(669, 637.43982, 1267.53821, 9.18110,   3.14159, 0.00000, -1.82292);
CreateObject(1271, 636.02734, 1263.52185, 11.02205,   0.00000, 0.00000, 26.04000);
CreateObject(1271, 635.69720, 1264.23560, 11.02205,   0.00000, 0.00000, 26.04000);
CreateObject(1271, 635.78027, 1263.90491, 11.65148,   0.00000, 0.00000, 26.04000);
CreateObject(1271, 628.29950, 1257.46533, 11.02205,   0.00000, 0.00000, 26.04000);
CreateObject(1271, 639.96082, 1232.22241, 11.02205,   0.00000, 0.00000, 26.04000);
CreateObject(1271, 640.82257, 1232.75305, 11.02205,   0.00000, 0.00000, 26.04000);
CreateObject(3637, 649.60468, 1277.35461, 18.51167,   0.00000, 0.00000, -63.96000);
CreateObject(19362, -101.06647, 1088.31689, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -97.86024, 1088.36206, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -94.77967, 1088.42163, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -88.78703, 1088.53174, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -91.99690, 1072.95703, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -87.24000, 1083.91846, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -87.24010, 1087.01868, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -82.53560, 1082.42139, 20.37520,   0.00000, 0.00000, 90.00000);
CreateObject(19362, -85.70536, 1082.42651, 20.37520,   0.00000, 0.00000, 90.00000);
CreateObject(19362, -81.01700, 1077.66711, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -81.02000, 1080.77686, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -81.02000, 1074.48730, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -88.85420, 1072.98901, 20.37520,   0.00000, 0.00000, 90.00000);
CreateObject(19362, -82.56590, 1072.98950, 20.37520,   0.00000, 0.00000, 90.00000);
CreateObject(19362, -85.71420, 1072.99036, 20.37520,   0.00000, 0.00000, 90.00000);
CreateObject(19362, -91.96909, 1088.47571, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -95.14117, 1072.90088, 20.37521,   0.00000, 0.00000, 91.07998);
CreateObject(19362, -98.32030, 1072.84009, 20.37520,   0.00000, 0.00000, 91.08000);
CreateObject(19362, -101.07820, 1072.79102, 20.37520,   0.00000, 0.00000, 91.08000);
CreateObject(19362, -102.58522, 1086.74817, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -102.58760, 1083.60669, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -102.59450, 1080.44714, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -102.59240, 1077.28101, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -102.59240, 1077.28101, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19362, -102.59300, 1074.27527, 20.37520,   0.00000, 0.00000, 180.00000);
CreateObject(19356, -88.96261, 1086.95959, 22.03454,   0.00000, 90.00000, 0.00000);
CreateObject(19356, -92.39983, 1086.88269, 22.03454,   0.00000, 90.00000, 0.78000);
CreateObject(19356, -95.84648, 1086.83252, 22.03454,   0.00000, 90.00000, 0.78000);
CreateObject(19356, -99.25295, 1086.76697, 22.03454,   0.00000, 90.00000, 0.78000);
CreateObject(19356, -100.81586, 1086.73645, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -100.88878, 1083.55957, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -100.88568, 1080.37781, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -100.84828, 1077.21619, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -100.86086, 1074.43616, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -97.44084, 1074.45361, 22.03454,   0.00000, 90.00000, 0.18000);
CreateObject(19356, -93.95631, 1074.48315, 22.03454,   0.00000, 90.00000, 0.60000);
CreateObject(19356, -90.57169, 1074.51733, 22.03454,   0.00000, 90.00000, 0.60000);
CreateObject(19356, -87.12625, 1074.56873, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -84.44271, 1074.59290, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -82.80079, 1074.60266, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -82.75552, 1077.82764, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -82.72342, 1080.87183, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -86.17637, 1080.88855, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -89.00998, 1083.85107, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -92.45005, 1083.79395, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -95.89030, 1083.79150, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -98.49014, 1083.82019, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -97.63623, 1080.71509, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -97.62222, 1077.63513, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -94.25144, 1077.47705, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -90.79163, 1077.51648, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -87.42919, 1077.78796, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -85.68009, 1077.76135, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -94.15594, 1080.67773, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -90.69593, 1080.81628, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(19356, -89.51593, 1080.93640, 22.03454,   0.00000, 90.00000, 0.06000);
CreateObject(1468, -81.04572, 1085.07361, 19.93216,   0.00000, 0.00000, 89.88000);
CreateObject(1361, -80.86360, 1087.94177, 19.49500,   0.00000, 0.00000, 0.00000);
CreateObject(1493, -85.33861, 1082.51855, 18.68988,   0.00000, 0.00000, -0.24000);
CreateObject(5811, -75.69659, 1083.94763, 21.97635,   0.00000, 0.00000, -23.22000);
CreateObject(7606, -94.89304, 1088.10022, 23.92378,   0.00000, 0.00000, 91.20001);
CreateObject(1294, -86.96884, 1093.54370, 23.20313,   356.85840, 0.00000, -1.57080);
CreateObject(16767, -299.49335, 1090.39807, 24.74537,   0.00000, 0.00000, 269.52005);
CreateObject(1522, -306.52594, 1073.37158, 18.73630,   0.00000, 0.00000, 0.00000);
CreateObject(1522, -305.02411, 1073.34094, 18.73630,   0.00000, 0.00000, 0.00000);
CreateObject(19362, -55.43088, 1134.86804, 17.92666,   0.00000, 0.00000, 180.05994);
CreateObject(19362, -55.43342, 1136.80640, 17.92666,   0.00000, 0.00000, 180.05994);
CreateObject(17542, -46.36229, 1003.53485, 22.57101,   0.00000, 0.00000, 180.12001);
CreateObject(700, -35.35783, 1013.32239, 18.72126,   356.85840, 0.00000, 3.14159);
CreateObject(700, -25.52925, 1013.34265, 18.59223,   356.85840, 0.00000, 3.14159);
CreateObject(3640, -228.46588, 1034.36255, 23.13496,   0.00000, 0.00000, -0.48005);
CreateObject(17542, -337.00208, 1081.10852, 22.50734,   0.00000, 0.00000, 89.76000);
CreateObject(983, -330.45978, 1075.00427, 19.38898,   0.00000, 0.00000, 90.00002);
CreateObject(983, -327.21692, 1071.79114, 19.38900,   0.00000, 0.00000, 180.64990);
CreateObject(983, -327.14523, 1065.40759, 19.38900,   0.00000, 0.00000, 180.64990);
CreateObject(983, -328.46475, 1059.34167, 19.38900,   0.00000, 0.00000, 154.84996);
CreateObject(700, -327.37164, 1065.63635, 18.60600,   356.85840, 0.00000, 3.14159);
CreateObject(3640, 118.12450, 1043.55444, 17.01437,   0.00000, 0.00000, 180.95990);
CreateObject(3640, 103.21033, 1043.31775, 17.01437,   0.00000, 0.00000, 180.95990);
CreateObject(3627, 238.40280, 1368.10864, 9.52303,   0.00000, 0.00000, 0.96000);
CreateObject(1271, 187.39363, 1361.66418, 9.91250,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 200.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 195.21480, 1361.15637, 8.81340,   0.00000, 0.00000, 90.00000);
CreateObject(19356, 198.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 196.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 198.41815, 1361.15637, 8.81343,   0.00000, 0.00000, 90.00000);
CreateObject(19356, 194.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 192.00323, 1361.15161, 8.81340,   0.00000, 0.00000, 90.00000);
CreateObject(19356, 192.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 188.81671, 1361.14746, 8.81340,   0.00000, 0.00000, 90.00000);
CreateObject(19356, 190.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 188.00000, 1361.00000, 11.21660,   0.00000, 0.00000, 0.00000);
CreateObject(19356, 198.92038, 1360.18689, 12.88666,   0.00000, 90.00000, 0.00000);
CreateObject(19356, 195.41904, 1360.18909, 12.88666,   0.00000, 90.00000, 0.00000);
CreateObject(19356, 191.92180, 1360.18994, 12.88666,   0.00000, 90.00000, 0.00000);
CreateObject(19356, 188.43555, 1360.19934, 12.88666,   0.00000, 90.00000, 0.00000);
CreateObject(1271, 186.73027, 1360.42896, 9.91250,   0.00000, 0.00000, 0.00000);
CreateObject(1271, 186.39580, 1361.45264, 9.91250,   0.00000, 0.00000, 0.00000);
CreateObject(1583, 189.02299, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(1583, 191.11659, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(1583, 193.11620, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(1583, 195.01579, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(1583, 197.05659, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(1583, 199.17230, 1336.00000, 9.55110,   0.00000, 0.00000, 180.00000);
CreateObject(19377, 265.78162, 1873.87061, 7.77464,   0.00000, 0.00000, 86.39999);
CreateObject(19377, 283.66092, 1869.30432, 7.20694,   0.00000, 0.00000, 0.00000);
CreateObject(3389, 265.86221, 1852.89551, 7.75781,   356.85840, 0.00000, -1.57080);
CreateObject(3389, 264.89703, 1852.88916, 7.75781,   356.85840, 0.00000, -1.57080);
CreateObject(12860, -681.39008, 989.69049, 10.53193,   0.00000, 0.00000, -1.91990);
CreateObject(12861, -705.55377, 898.93378, 10.83910,   0.00000, 0.00000, -1.86000);
CreateObject(13198, -742.93341, 913.69397, 16.54630,   -1.73150, 0.00000, 0.00000);
CreateObject(5138, -661.68420, 972.71429, 19.03065,   0.00000, 0.00000, 178.74011);
CreateObject(691, -649.67096, 975.56464, 9.33594,   3.14159, 0.00000, 0.78540);
CreateObject(16139, -627.22717, 998.99402, -8.91228,   388.23874, -47.10003, 236.72168);
CreateObject(16139, -625.31976, 999.94537, -10.76911,   388.23874, -47.10003, 133.04176);
CreateObject(16139, -625.78186, 997.73572, -10.76911,   388.23874, -47.10003, 62.36174);
CreateObject(16139, -632.84528, 995.85162, -10.76911,   388.23874, -47.10003, 62.36174);
CreateObject(3620, -773.32892, 947.96613, 20.18839,   0.00000, 0.00000, -89.52005);
CreateObject(19377, -760.17499, 948.63727, 7.59504,   0.00000, 90.00000, 0.00000);
CreateObject(19377, -765.38745, 948.55768, 2.42050,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -760.60303, 943.82715, 2.42050,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -760.64850, 953.37775, 2.42050,   0.00000, 0.00000, 90.00000);
CreateObject(5299, -693.16638, 923.59192, 10.13022,   0.00000, 0.00000, 0.00000);
CreateObject(3858, -75.67740, 1167.89063, 22.70530,   0.00000, 0.00000, -45.00000);
CreateObject(19377, -75.65018, 1158.18604, 21.86113,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -75.66273, 1177.27869, 14.66391,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -75.66112, 1167.77942, 14.66172,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -75.65020, 1179.65356, 21.86110,   0.00000, 0.00000, 0.00000);
CreateObject(19454, -75.65020, 1167.37817, 25.35528,   0.00000, 0.00000, 0.00000);
CreateObject(19454, -75.65020, 1176.09851, 25.35530,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -80.50401, 1153.45313, 21.85717,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -90.06051, 1153.44495, 21.85459,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -99.63970, 1153.44629, 21.85460,   0.00000, 0.00000, 90.00000);
CreateObject(19454, -103.73240, 1153.44617, 22.28200,   90.00000, 0.00000, 90.00000);
CreateObject(19377, -105.40311, 1158.24231, 21.86113,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -105.40759, 1167.82849, 14.66172,   0.00000, 0.00000, 0.00000);
CreateObject(3858, -105.42514, 1168.76831, 22.73826,   0.00000, 0.00000, -45.00000);
CreateObject(19377, -105.40760, 1177.36328, 14.66170,   0.00000, 0.00000, 0.00000);
CreateObject(19454, -80.55220, 1184.38025, 25.35530,   0.00000, 0.00000, 90.00000);
CreateObject(19454, -77.32043, 1184.38562, 22.28200,   90.00000, 0.00000, 90.00000);
CreateObject(19454, -87.06544, 1184.38464, 22.28200,   90.00000, 0.00000, 90.00000);
CreateObject(19454, -93.61499, 1184.38806, 25.35530,   0.00000, 0.00000, 90.00000);
CreateObject(19454, -93.77359, 1184.40308, 22.28200,   90.00000, 0.00000, 90.00000);
CreateObject(19454, -100.53880, 1184.38623, 25.35530,   0.00000, 0.00000, 90.00000);
CreateObject(19377, -105.40760, 1179.65259, 21.86110,   0.00000, 0.00000, 0.00000);
CreateObject(19454, -103.69106, 1184.38293, 22.28200,   90.00000, 0.00000, 90.00000);
CreateObject(3858, -90.45071, 1184.45447, 19.76805,   -45.00000, -90.00000, 0.00000);
CreateObject(19454, -105.40760, 1166.00146, 25.35530,   0.00000, 0.00000, 0.00000);
CreateObject(19454, -105.40760, 1171.37390, 25.35530,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -80.90440, 1179.53735, 26.99270,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -91.40850, 1179.57642, 26.99270,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -100.16870, 1179.55457, 26.99290,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -100.15093, 1169.96716, 26.99281,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -100.19792, 1160.40735, 26.99281,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -100.16500, 1158.22656, 26.99270,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -89.67830, 1158.36694, 26.99270,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -80.83630, 1158.34485, 26.97680,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -80.94200, 1167.92798, 26.99999,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -80.94380, 1170.99182, 26.99290,   0.00000, 90.00000, 0.00000);
CreateObject(3858, -92.15343, 1169.28430, 26.99224,   -45.00000, 90.00000, 0.00000);
CreateObject(3858, -86.36934, 1169.46094, 26.99224,   -45.00000, 90.00000, 0.00000);
CreateObject(3850, -95.47982, 1155.56616, 19.23610,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -95.73917, 1157.93970, 19.48759,   0.00000, 0.00000, 0.00000);
CreateObject(3850, -98.10267, 1158.35706, 19.23610,   0.00000, 0.00000, 90.00000);
CreateObject(3850, -103.21802, 1158.30786, 19.23610,   0.00000, 0.00000, 90.00000);
CreateObject(1361, -100.68090, 1158.07568, 19.48760,   0.00000, 0.00000, 0.00000);
CreateObject(3850, -77.69190, 1158.35706, 19.23610,   0.00000, 0.00000, 90.00000);
CreateObject(1361, -80.09297, 1158.21411, 19.48759,   0.00000, 0.00000, 0.00000);
CreateObject(3850, -82.55210, 1158.35718, 19.23610,   0.00000, 0.00000, 90.00000);
CreateObject(1361, -85.08382, 1158.06445, 19.48759,   0.00000, 0.00000, 0.00000);
CreateObject(3850, -85.24099, 1155.60083, 19.23610,   0.00000, 0.00000, 0.00000);
CreateObject(869, -77.72256, 1155.59436, 18.73374,   0.00000, 0.00000, 0.00000);
CreateObject(869, -79.68266, 1155.55920, 18.73374,   0.00000, 0.00000, 0.00000);
CreateObject(869, -82.94357, 1155.18652, 18.73374,   0.00000, 0.00000, 170.03987);
CreateObject(869, -84.04189, 1155.82971, 18.73374,   0.00000, 0.00000, 259.14001);
CreateObject(869, -83.03217, 1156.72351, 18.73374,   0.00000, 0.00000, 157.14006);
CreateObject(869, -80.01173, 1156.81458, 18.73374,   0.00000, 0.00000, -210.17996);
CreateObject(869, -78.26943, 1156.81726, 18.73374,   0.00000, 0.00000, -210.17996);
CreateObject(869, -76.93382, 1155.55103, 18.73374,   0.00000, 0.00000, -278.87997);
CreateObject(869, -78.18935, 1154.74023, 18.73374,   0.00000, 0.00000, -374.15994);
CreateObject(869, -81.90981, 1154.88989, 18.73374,   0.00000, 0.00000, -374.15994);
CreateObject(869, -81.68425, 1156.82947, 18.73374,   0.00000, 0.00000, -550.91980);
CreateObject(823, -79.30185, 1154.26831, 18.81873,   0.00000, 0.00000, 35.51998);
CreateObject(823, -82.43830, 1154.87866, 18.81873,   0.00000, 0.00000, 118.79998);
CreateObject(869, -103.11921, 1155.25610, 19.15618,   0.00000, 0.00000, -11.46000);
CreateObject(869, -102.92764, 1156.40527, 19.15618,   0.00000, 0.00000, -195.47997);
CreateObject(869, -100.05043, 1155.35925, 19.15618,   0.00000, 0.00000, -180.78001);
CreateObject(869, -97.96816, 1156.38049, 19.15618,   0.00000, 0.00000, -180.78001);
CreateObject(869, -97.92985, 1155.48523, 19.15618,   0.00000, 0.00000, -180.78001);
CreateObject(869, -100.46675, 1156.32446, 19.15618,   0.00000, 0.00000, -180.78001);
CreateObject(823, -102.98228, 1154.28015, 18.81873,   0.00000, 0.00000, 118.79998);
CreateObject(823, -98.82668, 1154.27576, 18.81873,   0.00000, 0.00000, 56.09999);
CreateObject(1364, -76.67581, 1164.81543, 19.51377,   0.00000, 0.00000, -89.63998);
CreateObject(1364, -76.62276, 1172.81421, 19.51377,   0.00000, 0.00000, -89.51997);
CreateObject(1364, -104.52322, 1165.35315, 19.51380,   0.00000, 0.00000, 90.00000);
CreateObject(1364, -104.52235, 1172.76526, 19.51380,   0.00000, 0.00000, 90.00000);
CreateObject(3935, -94.77119, 1154.11450, 20.20933,   0.00000, 0.00000, 0.00000);
CreateObject(2747, -102.67434, 1165.36914, 19.09518,   0.00000, 0.00000, 90.00001);
CreateObject(2747, -102.54524, 1172.84680, 19.09518,   0.00000, 0.00000, 90.00001);
CreateObject(2747, -78.60347, 1164.80786, 19.09518,   0.00000, 0.00000, 90.00001);
CreateObject(2747, -78.26724, 1172.77942, 19.09518,   0.00000, 0.00000, 90.00001);
CreateObject(3850, -102.08123, 1182.51086, 19.23610,   0.00000, 0.00000, 0.00000);
CreateObject(3850, -78.92255, 1182.54675, 19.23610,   0.00000, 0.00000, 0.00000);
CreateObject(700, -76.07832, 1188.03882, 19.01563,   356.85840, 0.00000, 3.14159);
CreateObject(700, -105.40868, 1188.18848, 19.01563,   356.85840, 0.00000, -46.29843);
CreateObject(1594, -90.43716, 1181.41809, 19.18353,   0.00000, 0.00000, 0.00000);
CreateObject(2747, -90.55421, 1154.26868, 18.32783,   0.00000, 0.00000, 179.75993);
CreateObject(1361, -102.19836, 1180.32605, 19.48759,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -79.07494, 1180.42505, 19.48759,   0.00000, 0.00000, 0.00000);
CreateObject(1832, -105.03432, 1175.56006, 18.73534,   0.00000, 0.00000, 90.00000);
CreateObject(3660, -87.41251, 1178.54260, 21.21618,   0.00000, 0.00000, 90.00000);
CreateObject(3660, -94.09988, 1178.56238, 21.21618,   0.00000, 0.00000, 90.00000);
CreateObject(1594, -90.43720, 1177.41663, 19.18350,   0.00000, 0.00000, 0.00000);
CreateObject(1594, -90.43720, 1172.65247, 19.18350,   0.00000, 0.00000, 0.00000);
CreateObject(3935, -85.94698, 1154.20337, 20.20933,   0.00000, 0.00000, 0.00000);
CreateObject(13131, -41.10724, 848.23364, 16.56828,   0.00000, 0.00000, 298.08038);
CreateObject(1522, -45.51270, 853.94330, 16.84730,   0.00000, 0.00000, 27.84000);
CreateObject(12940, -345.43210, 1594.16846, 78.63950,   0.00000, 0.00000, 226.19981);
CreateObject(19356, -224.52428, 1188.29041, 20.46698,   0.00000, 0.00000, 89.51999);
CreateObject(19356, -227.67371, 1188.31165, 20.46698,   0.00000, 0.00000, 89.51999);
CreateObject(19356, -230.86560, 1188.34326, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19356, -234.05290, 1188.37622, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19356, -235.57013, 1186.70886, 20.46700,   0.00000, 0.00000, 180.00000);
CreateObject(19356, -235.56084, 1183.51001, 20.46700,   0.00000, 0.00000, 180.00000);
CreateObject(19356, -235.55847, 1180.30603, 20.46700,   0.00000, 0.00000, 180.00000);
CreateObject(19356, -233.93845, 1178.76526, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19356, -230.74817, 1178.73755, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19356, -227.60141, 1178.70251, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19356, -224.39528, 1178.67749, 20.46700,   0.00000, 0.00000, 89.52000);
CreateObject(19377, -221.76553, 1183.60706, 22.22548,   0.00000, 90.00000, 89.87997);
CreateObject(19377, -231.39227, 1183.59277, 22.22548,   0.00000, 90.00000, 89.87997);
CreateObject(1522, -232.99495, 1188.38293, 18.71003,   0.00000, 0.00000, 0.00000);
CreateObject(1280, -227.31860, 1188.71313, 19.10881,   0.00000, 0.00000, -89.99997);
CreateObject(983, -231.47296, 1185.98389, 19.40596,   0.00000, 0.00000, 0.00000);
CreateObject(983, -232.99365, 1185.95642, 19.40596,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -229.12297, 1188.91760, 19.45554,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -225.57394, 1188.85327, 19.45554,   0.00000, 0.00000, 0.00000);
CreateObject(982, -223.92973, 1208.41150, 19.40886,   0.00000, 0.00000, -89.94002);
CreateObject(982, -252.71416, 1208.39758, 19.40886,   0.00000, 0.00000, -89.94002);
CreateObject(982, -211.15636, 1221.23132, 19.40890,   0.00000, 0.00000, 180.00000);
CreateObject(982, -266.07956, 1221.15747, 19.40890,   0.00000, 0.00000, 182.52002);
CreateObject(19366, -219.44888, 1229.49048, 20.43376,   0.00000, 0.00000, 0.00000);
CreateObject(19366, -219.45840, 1226.30627, 20.43376,   0.00000, 0.00000, 0.00000);
CreateObject(19366, -220.99637, 1224.77686, 20.43380,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -224.19730, 1224.77087, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -227.39720, 1224.77466, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -230.56870, 1224.77539, 20.43380,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -232.08035, 1226.40381, 20.43376,   0.00000, 0.00000, 0.00000);
CreateObject(19366, -232.07512, 1229.62317, 20.43376,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -228.24045, 1227.98425, 22.10040,   0.00000, 90.00000, 0.00000);
CreateObject(19375, -223.16878, 1227.98779, 22.10040,   0.00000, 90.00000, 0.00000);
CreateObject(1361, -236.76201, 1208.49524, 19.47450,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -239.89880, 1208.49524, 19.47450,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -215.17934, 1222.08093, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -215.15405, 1218.08032, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -215.22827, 1214.05811, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -215.23000, 1210.41699, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -220.44991, 1210.45068, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -220.35291, 1213.96948, 18.82320,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -220.29150, 1217.90942, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -220.16966, 1221.88818, 18.82317,   0.00000, 0.00000, 0.00000);
CreateObject(1360, -223.78983, 1211.28455, 19.47450,   0.00000, 0.00000, 0.00000);
CreateObject(1360, -223.78979, 1216.39636, 19.47450,   0.00000, 0.00000, 0.00000);
CreateObject(1360, -224.77837, 1216.37463, 19.47450,   0.00000, 0.00000, 90.00000);
CreateObject(1360, -224.60023, 1211.29541, 19.47450,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -229.63597, 1210.84204, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -229.45180, 1215.78406, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -229.38655, 1220.42554, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -234.84641, 1220.45935, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -234.90994, 1215.77820, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -234.95375, 1210.73694, 19.54859,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -241.46843, 1220.61279, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -241.35770, 1215.75574, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -241.32782, 1210.99011, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -246.08362, 1220.68140, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -246.08621, 1215.79749, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -246.18941, 1210.97778, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(14401, -261.61472, 1215.99011, 19.43912,   0.00000, 0.00000, 0.00000);
CreateObject(1360, -262.25058, 1218.84351, 19.47450,   0.00000, 0.00000, 90.00000);
CreateObject(1360, -262.29337, 1213.45081, 19.47450,   0.00000, 0.00000, 90.00000);
CreateObject(1597, -252.81471, 1220.52429, 21.20270,   0.00000, 0.00000, 90.00000);
CreateObject(1597, -252.73950, 1211.47278, 21.20270,   0.00000, 0.00000, 90.00000);
CreateObject(1597, -249.41562, 1216.43518, 21.20270,   0.00000, 0.00000, 0.00000);
CreateObject(1281, -252.19647, 1217.82751, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -252.21864, 1214.54480, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -255.31926, 1214.44360, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(1281, -255.35846, 1217.80493, 19.54860,   0.00000, 0.00000, 90.00000);
CreateObject(14565, -223.36569, 1230.76819, 21.66460,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -214.75410, 1229.80322, 20.43376,   0.00000, 0.00000, 0.00000);
CreateObject(19366, -216.30295, 1228.27283, 20.43380,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -217.99449, 1228.27136, 20.43380,   0.00000, 0.00000, 90.00000);
CreateObject(19375, -219.95952, 1233.05054, 21.99209,   0.00000, 90.00000, 0.00000);
CreateObject(19366, -230.44067, 1229.70764, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -227.28059, 1229.70703, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -224.06754, 1229.71973, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(19366, -220.87939, 1229.71936, 18.10550,   0.00000, 0.00000, 90.00000);
CreateObject(982, -68.47282, 1208.43152, 19.04295,   0.00000, 0.00000, 90.00000);
CreateObject(983, -126.67036, 1244.92407, 17.80925,   0.00000, 0.00000, 98.21999);
CreateObject(983, -123.06717, 1242.19202, 17.80925,   0.00000, 0.00000, 187.85989);
CreateObject(652, -122.93771, 1238.05298, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -121.97383, 1234.16382, 17.80925,   0.00000, 0.00000, 185.57993);
CreateObject(652, -122.08708, 1229.89636, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -121.15923, 1225.79077, 18.12550,   0.00000, 0.00000, 185.33994);
CreateObject(652, -121.35198, 1221.54285, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -120.77958, 1217.63770, 18.46425,   0.00000, 0.00000, 180.95995);
CreateObject(652, -121.14935, 1213.29968, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -110.04425, 1244.98096, 15.94624,   0.00000, 0.00000, 99.66003);
CreateObject(983, -106.44162, 1242.29028, 15.83951,   0.00000, 0.00000, 187.85989);
CreateObject(983, -105.56796, 1235.98718, 15.83951,   0.00000, 0.00000, 187.85989);
CreateObject(983, -112.66563, 1241.29480, 16.62119,   0.00000, 0.00000, 190.25989);
CreateObject(652, -111.95515, 1236.99048, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -111.46925, 1232.98047, 17.19488,   0.00000, 0.00000, 187.07996);
CreateObject(652, -111.15166, 1228.68542, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -110.72342, 1224.57373, 17.92214,   0.00000, 0.00000, 186.29999);
CreateObject(652, -110.52575, 1220.42102, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(983, -110.39139, 1216.38196, 18.54043,   0.00000, 0.00000, 182.33998);
CreateObject(652, -110.45964, 1212.29504, 12.04155,   356.85840, 0.00000, -2.61799);
CreateObject(19377, 233.30801, 1822.45764, 6.41009,   0.00000, 0.00000, 0.00000);
CreateObject(19377, -112.40765, 1125.39282, 16.24840,   0.00000, 0.00000, 89.81998);
CreateObject(19363, 57.99790, 1212.21411, 19.56215,   0.00000, 0.00000, 90.00000);
CreateObject(19363, 59.50877, 1213.87561, 19.56210,   0.00000, 0.00000, 0.00000);
CreateObject(19363, 59.51017, 1217.06201, 19.56210,   0.00000, 0.00000, 0.00000);
CreateObject(19363, 58.72122, 1220.02869, 19.56210,   0.00000, 0.00000, 29.87999);
CreateObject(19363, 57.68610, 1213.90466, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(19363, 57.67674, 1217.14502, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(19363, 57.67122, 1220.32397, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(19363, 58.45807, 1224.50488, 19.56210,   0.00000, 0.00000, 0.00000);
CreateObject(19363, 58.44923, 1227.68799, 19.56210,   0.00000, 0.00000, 0.00000);
CreateObject(19363, 56.90848, 1229.19141, 19.56210,   0.00000, 0.00000, 90.00000);
CreateObject(19363, 55.38404, 1227.51599, 19.56210,   0.00000, 0.00000, 0.00000);
CreateObject(19363, 56.76212, 1227.64990, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(19363, 57.67672, 1223.52454, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(19363, 57.67612, 1226.73157, 21.22600,   0.00000, 90.00000, 0.00000);
CreateObject(1522, 58.55642, 1221.21875, 17.79110,   0.00000, 0.00000, 90.00000);
CreateObject(19363, 58.47734, 1221.73889, 16.27068,   0.00000, 0.00000, 0.00000);
CreateObject(983, 58.62585, 1211.79150, 18.52195,   0.00000, 0.00000, 4.68000);
CreateObject(3465, 66.99377, 1217.13843, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(3465, 67.87479, 1220.51294, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(3465, 68.17446, 1221.66272, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(3465, 72.83194, 1215.53052, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(3465, 73.71764, 1218.93237, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(3465, 74.00566, 1220.06030, 19.39202,   0.00000, 0.00000, -14.12000);
CreateObject(983, 56.40102, 1227.43115, 18.40516,   0.00000, 0.00000, 146.70012);
CreateObject(984, 64.47253, 1229.06763, 18.37698,   0.00000, 0.00000, 80.70007);
CreateObject(982, 100.25718, 1188.01245, 18.32973,   0.00000, 0.00000, -91.07999);
CreateObject(982, 66.61266, 1188.38489, 18.32973,   0.00000, 0.00000, -89.81999);
CreateObject(982, 41.02792, 1188.34021, 18.32973,   0.00000, 0.00000, -89.81999);
CreateObject(983, 28.22920, 1185.08862, 18.24353,   0.00000, 0.00000, 0.00000);
CreateObject(982, 93.92090, 1153.38562, 18.32973,   0.00000, 0.00000, -90.59998);
CreateObject(982, 108.93390, 1165.85095, 18.32973,   0.00000, 0.00000, -10.07999);
CreateObject(983, 111.76036, 1181.63586, 18.35648,   0.00000, 0.00000, -10.08000);
CreateObject(983, 112.37254, 1184.66772, 18.35648,   0.00000, 0.00000, -11.16000);
CreateObject(983, 81.09090, 1156.70691, 18.33681,   0.00000, 0.00000, 0.00000);
CreateObject(652, 47.80618, 1181.41113, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 41.51095, 1180.32971, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 40.17924, 1169.80322, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 39.92969, 1160.56396, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 40.23459, 1153.24182, 16.10563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 51.00850, 1152.63586, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(652, 60.32813, 1152.72656, 16.26563,   356.85840, 0.00000, -2.61799);
CreateObject(983, 1.23838, 1186.31641, 19.05293,   0.00000, 0.00000, 90.00000);
CreateObject(983, 24.19790, 1186.37488, 19.05293,   0.00000, 0.00000, 90.00000);
CreateObject(19386, -217.79980, 981.33008, 20.22000,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -217.79980, 986.93762, 16.71450,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -217.79984, 975.71210, 16.71450,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -222.54636, 991.66772, 16.71450,   0.00000, 0.00000, 90.00000);
CreateObject(19375, -227.26849, 986.93463, 16.71450,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -227.27467, 977.31378, 16.71450,   0.00000, 0.00000, 0.00000);
CreateObject(19375, -222.59572, 971.79926, 16.71450,   0.00000, 0.00000, 80.33997);
CreateObject(19377, -222.59991, 975.14465, 21.93436,   0.00000, 90.00000, 0.00000);
CreateObject(19377, -222.60193, 982.70013, 21.93436,   0.00000, 90.00000, 0.00000);
CreateObject(19377, -222.59213, 988.14423, 21.93436,   0.00000, 90.00000, 0.00000);
CreateObject(1491, -217.77206, 980.58948, 18.46407,   0.00000, 0.00000, 89.88000);
CreateObject(669, -209.99519, 1005.78546, 18.77344,   356.85840, 0.00000, 3.14159);
CreateObject(669, -227.08377, 1005.76483, 18.77344,   356.85840, 0.00000, 3.14159);
CreateObject(984, -218.99890, 1008.21863, 19.33518,   0.00000, 0.00000, 89.76003);
CreateObject(982, -230.52315, 989.15997, 19.24006,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -230.35660, 1001.89667, 19.35415,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -225.44456, 1008.27039, 19.47835,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -212.34367, 1008.16541, 19.47835,   0.00000, 0.00000, 0.00000);
CreateObject(983, -228.81940, 973.62604, 19.15565,   0.00000, 0.00000, 32.10000);
CreateObject(983, -223.92914, 971.17175, 19.15565,   0.00000, 0.00000, 94.43996);
CreateObject(983, -214.54802, 970.95758, 18.90772,   0.00000, 0.00000, 88.97997);
CreateObject(983, -206.52710, 970.84985, 18.28888,   0.00000, 0.00000, 89.03995);
CreateObject(1361, -210.57660, 971.08960, 18.76357,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -203.14693, 970.96271, 18.20044,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -215.47070, 975.24329, 18.39409,   0.00000, 0.00000, 0.00000);
CreateObject(1361, -215.52203, 983.13184, 18.39409,   0.00000, 0.00000, 0.00000);
CreateObject(2229, -217.74901, 980.63849, 18.43891,   0.00000, 0.00000, 92.75998);
CreateObject(2229, -217.76210, 982.63892, 18.43891,   0.00000, 0.00000, 92.75998);
CreateObject(1594, -225.96581, 993.41693, 19.07073,   0.00000, 0.00000, 0.00000);
CreateObject(1594, -222.95078, 993.39313, 19.07073,   0.00000, 0.00000, 0.00000);
CreateObject(1594, -219.70590, 993.26465, 19.07073,   0.00000, 0.00000, 0.00000);
CreateObject(14401, -217.42377, 971.32581, 11.89802,   0.00000, 90.00000, 0.00000);
CreateObject(2181, -226.66600, 991.08295, 18.48179,   0.00000, 0.00000, 360.35989);
CreateObject(2181, -224.52580, 991.08289, 18.48180,   0.00000, 0.00000, 360.35989);
CreateObject(2181, -219.40669, 991.08289, 18.48180,   0.00000, 0.00000, 360.35989);
CreateObject(2181, -221.48650, 991.08289, 18.48180,   0.00000, 0.00000, 360.35989);
CreateObject(1361, -222.57735, 991.01129, 18.54817,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -226.08209, 989.94342, 18.49980,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -224.04208, 989.96606, 18.49980,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -220.92223, 989.93121, 18.49980,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -218.82237, 989.90106, 18.49980,   0.00000, 0.00000, 0.00000);
CreateObject(2165, -223.74286, 984.28888, 18.53740,   0.00000, 0.00000, 90.00000);
CreateObject(2165, -224.81738, 985.25262, 18.53740,   0.00000, 0.00000, -90.00000);
CreateObject(2165, -224.79834, 980.55151, 18.51830,   0.00000, 0.00000, -90.00000);
CreateObject(2165, -223.75436, 979.55206, 18.52308,   0.00000, 0.00000, 90.00000);
CreateObject(2165, -223.78102, 975.70117, 18.52308,   0.00000, 0.00000, 90.00000);
CreateObject(2165, -224.81421, 976.70148, 18.51830,   0.00000, 0.00000, -90.00000);
CreateObject(2165, -220.01170, 975.91980, 18.52308,   0.00000, 0.00000, 179.28011);
CreateObject(2165, -221.02850, 974.86395, 18.52310,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -220.35847, 973.71155, 18.49980,   0.00000, 0.00000, 0.00000);
CreateObject(1806, -220.58113, 977.12616, 18.49980,   0.00000, 0.00000, 180.00000);
CreateObject(1806, -222.58281, 976.34528, 18.49980,   0.00000, 0.00000, 90.00000);
CreateObject(1806, -222.54109, 980.20166, 18.49980,   0.00000, 0.00000, 90.00000);
CreateObject(1806, -222.59169, 984.99915, 18.49980,   0.00000, 0.00000, 90.00000);
CreateObject(1806, -225.86790, 984.54858, 18.49980,   0.00000, 0.00000, -90.00000);
CreateObject(1806, -225.90703, 979.91541, 18.49980,   0.00000, 0.00000, -90.00000);
CreateObject(1806, -225.93631, 976.15521, 18.49980,   0.00000, 0.00000, -90.00000);
CreateObject(10631, -293.91956, 1192.88550, 22.99095,   0.00000, 0.00000, -90.00000);
CreateObject(4857, -270.84958, 1213.37378, 20.96531,   0.00000, 0.00000, -78.71999);
CreateObject(983, -276.13812, 1204.90259, 19.38130,   0.00000, 0.00000, -56.22000);
CreateObject(983, -284.45822, 1195.43103, 19.38130,   0.00000, 0.00000, -33.41999);
CreateObject(983, -280.73260, 1200.61121, 19.38130,   0.00000, 0.00000, -38.10001);
CreateObject(14401, -217.39575, 972.40558, 11.89802,   0.00000, 90.00000, 0.00000);
CreateObject(18239, -57.67712, 842.74323, 16.80481,   0.00000, 0.00000, -61.55998);
CreateObject(8068, -83.40833, 1055.34033, 23.77970,   0.00000, 0.00000, 360.00003);
CreateObject(982, -283.35507, 1520.31555, 75.09628,   0.00000, 0.00000, -48.18000);
CreateObject(982, -272.39609, 1541.53625, 75.09628,   0.00000, 0.00000, -6.11998);
CreateObject(982, -280.08350, 1563.31543, 75.03470,   0.00000, 0.00000, 45.00000);
CreateObject(984, -293.63864, 1576.89856, 74.98022,   0.00000, 0.00000, 44.76001);
CreateObject(983, -300.37244, 1583.75525, 75.07952,   0.00000, 0.00000, 44.70002);
CreateObject(983, -305.17175, 1584.12073, 75.07952,   0.00000, 0.00000, 126.66003);
CreateObject(984, -312.14520, 1577.63074, 74.98022,   0.00000, 0.00000, 135.77995);
CreateObject(983, -317.73450, 1571.89319, 75.02280,   0.00000, 0.00000, 135.83986);
CreateObject(983, -317.96472, 1567.07629, 75.02280,   0.00000, 0.00000, 218.45984);
CreateObject(982, -306.94455, 1555.48499, 75.02013,   0.00000, 0.00000, 45.00000);
CreateObject(984, -293.40109, 1541.89868, 74.96566,   0.00000, 0.00000, 44.76001);
CreateObject(982, -303.59238, 1534.46472, 75.03275,   0.00000, 0.00000, -89.63998);
CreateObject(982, -360.13522, 1536.75671, 75.01857,   0.00000, 0.00000, -100.25999);
CreateObject(983, -375.82153, 1539.71985, 75.04626,   0.00000, 0.00000, 77.46000);
CreateObject(983, -380.92712, 1542.93835, 75.04626,   0.00000, 0.00000, 37.80000);
CreateObject(984, -382.90744, 1551.85095, 74.96469,   0.00000, 0.00000, 0.00000);
CreateObject(982, -373.40878, 1569.69702, 75.01857,   0.00000, 0.00000, -44.99998);
CreateObject(982, -355.30908, 1587.80249, 74.81857,   -1.14000, -0.36000, -44.99998);
CreateObject(982, -375.62598, 1579.32813, 75.01857,   0.00000, 0.00000, -46.43999);
CreateObject(983, -386.94861, 1568.07715, 75.27813,   0.00000, 0.00000, -39.42001);
CreateObject(983, -390.07111, 1562.60120, 75.11765,   0.00000, 0.00000, -19.92001);
CreateObject(982, -390.62943, 1546.81921, 75.02541,   0.00000, 0.00000, 2.22002);
CreateObject(982, -377.66660, 1531.19885, 75.02541,   0.00000, 0.00000, 77.16005);
CreateObject(984, -358.91006, 1527.18518, 74.96469,   0.00000, 0.00000, 79.79998);
CreateObject(983, -351.03107, 1525.77136, 75.01189,   0.00000, 0.00000, 79.61992);
CreateObject(984, -347.45465, 1517.84253, 74.96469,   0.00000, 0.00000, 0.00000);
CreateObject(982, -329.14993, 1534.40967, 75.03275,   0.00000, 0.00000, -89.99998);
CreateObject(982, -334.64297, 1511.42480, 75.01504,   0.00000, 0.00000, 89.94000);
CreateObject(984, -315.44357, 1511.42529, 74.96469,   0.00000, 0.00000, 90.11998);
CreateObject(652, -292.93640, 1511.74304, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -309.42294, 1511.21106, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -347.63535, 1511.35986, 70.13844,   0.00000, 0.00000, 0.00000);
CreateObject(652, -347.88513, 1524.28711, 70.12895,   0.00000, 0.00000, 0.00000);
CreateObject(652, -290.78204, 1534.46106, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -289.01172, 1536.93530, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -288.44650, 1535.76062, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -288.99368, 1534.71790, 71.51993,   0.00000, 0.00000, 0.00000);
CreateObject(652, -271.22620, 1553.94275, 68.06125,   0.00000, 0.00000, 0.00000);
CreateObject(652, -273.87958, 1528.46985, 69.08495,   0.00000, 0.00000, 0.00000);
CreateObject(652, -302.52499, 1585.78455, 69.51265,   0.00000, 0.00000, -1.86000);
CreateObject(652, -320.25754, 1569.03357, 67.68784,   0.00000, 0.00000, -7.74000);
CreateObject(652, -347.52859, 1549.46948, 68.74953,   0.00000, 0.00000, -7.74000);
CreateObject(652, -322.70956, 1549.78845, 68.69978,   0.00000, 0.00000, -7.74000);
CreateObject(652, -380.27756, 1541.01526, 71.51993,   0.00000, 0.00000, -7.74000);
CreateObject(652, -381.55292, 1541.65820, 71.51993,   0.00000, 0.00000, -7.74000);
CreateObject(652, -382.26089, 1542.95959, 71.51993,   0.00000, 0.00000, -7.74000);
CreateObject(652, -382.45990, 1544.08777, 71.51993,   0.00000, 0.00000, -7.74000);
CreateObject(652, -382.96463, 1558.15344, 66.04205,   0.00000, 0.00000, -7.74000);
CreateObject(652, -382.64136, 1560.24866, 66.04205,   0.00000, 0.00000, -7.74000);
CreateObject(1256, -324.07922, 1549.03772, 75.14025,   0.00000, 0.00000, 89.69999);
CreateObject(933, -320.02072, 1538.17297, 74.47286,   0.00000, 0.00000, 0.00000);
CreateObject(933, -318.41727, 1538.36230, 74.58728,   20.94000, -48.83999, 0.00000);
CreateObject(9833, -310.31357, 1542.76147, 77.27206,   0.00000, 0.00000, 0.00000);
CreateObject(3640, 45.53225, 1131.23230, 23.07926,   0.00000, 0.00000, -90.36001);
CreateObject(3640, 45.49189, 1115.89087, 23.07926,   0.00000, 0.00000, -90.36001);
CreateObject(645, -193.00708, 1184.85107, 18.78011,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.97386, 1179.97046, 18.78011,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.92102, 1175.30872, 18.78011,   0.00000, 0.00000, 0.00000);
CreateObject(645, -193.06996, 1170.65930, 18.78011,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.98883, 1165.67896, 18.78011,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.91747, 1160.41772, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.98788, 1155.23889, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.80785, 1149.78992, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.79750, 1144.36951, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.96657, 1139.06958, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.99550, 1133.78894, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.94154, 1128.18335, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.93478, 1123.09595, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -193.03542, 1117.38208, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(645, -192.83424, 1111.64453, 18.77067,   0.00000, 0.00000, 0.00000);
CreateObject(16096, 99.10737, 1921.15588, 18.92352,   356.85840, 0.00000, 3.14159);
CreateObject(19377, 214.13750, 1875.54736, 10.89730,   0.00000, 0.00000, 90.00000);
CreateObject(19377, 268.85358, 1883.45422, 16.26610,   0.00000, 90.00000, 0.00000);
CreateObject(16095, 245.56842, 1863.09229, 16.63281,   356.85840, 0.00000, 38.51795);
CreateObject(17536, 678.58606, 1831.88025, 16.22858,   0.00000, 0.00000, -97.25992);
CreateObject(3642, -105.70684, 1360.53601, 12.14569,   0.00000, 0.00000, 96.06000);
CreateObject(8674, -106.61921, 1350.89087, 9.62280,   0.00000, 0.00000, 94.79991);
CreateObject(14872, -75.49169, 1353.93665, 9.38777,   0.00000, 0.00000, 0.00000);
CreateObject(14872, -77.63887, 1356.30811, 9.57155,   0.00000, 0.00000, 75.71992);
CreateObject(700, -77.47651, 1355.19019, 9.48846,   0.00000, 0.00000, 0.00000);
CreateObject(700, -79.69723, 1369.28638, 9.48846,   0.00000, 0.00000, 0.00000);
CreateObject(14872, -80.37463, 1371.42969, 9.38777,   0.00000, 0.00000, 95.63999);
CreateObject(14872, -77.97781, 1369.63513, 9.38777,   0.00000, 0.00000, -13.08001);
CreateObject(933, -98.62913, 1358.33875, 9.22588,   0.00000, 0.00000, 0.00000);
CreateObject(933, -102.29086, 1367.06018, 10.02808,   63.48003, -144.29999, 21.24000);
CreateObject(1280, -99.77782, 1364.48682, 9.59517,   0.00000, 0.00000, -174.05998);
CreateObject(3035, -79.23711, 1353.32349, 10.41427,   0.00000, 0.00000, 94.38004);
CreateObject(849, -98.33972, 1371.75708, 9.51283,   0.00000, 0.00000, -33.35999);
CreateObject(852, -99.26746, 1374.21423, 9.20492,   0.00000, 0.00000, 0.00000);
CreateObject(832, -110.83317, 1381.85352, 10.90330,   0.00000, 0.00000, 44.16000);
CreateObject(926, -97.60658, 1373.05762, 9.45925,   0.00000, 0.00000, -24.84000);
CreateObject(1413, -106.00496, 1343.12878, 10.11540,   0.00000, 0.00000, 95.27998);
CreateObject(1369, -80.70570, 1369.32983, 9.78601,   0.00000, 0.00000, -50.64000);
CreateObject(1440, -100.72739, 1355.14050, 9.47728,   0.00000, 0.00000, 4.14000);
CreateObject(700, -103.68714, 1391.73108, 8.81222,   0.00000, 0.00000, 0.00000);
CreateObject(1432, -82.61187, 1372.73987, 9.36705,   0.00000, 0.00000, -20.46001);
CreateObject(1432, -83.38908, 1376.79700, 9.36705,   0.00000, 0.00000, -20.46001);
CreateObject(1327, -90.02191, 1366.06567, 9.20279,   0.00000, 90.00000, 0.00000);
CreateObject(1264, -89.07394, 1367.20386, 9.53893,   0.00000, 0.00000, 0.00000);
CreateObject(1264, -88.65772, 1366.35779, 9.53893,   0.00000, 0.00000, 0.00000);
CreateObject(1264, -81.95427, 1370.08154, 9.53893,   0.00000, 0.00000, 0.00000);
CreateObject(1264, -79.26637, 1351.72620, 10.02870,   0.00000, 0.00000, 0.00000);
CreateObject(1264, -80.37527, 1353.30896, 9.97749,   0.00000, 0.00000, 0.00000);

//---------- AUTA -----------------------------------------------------------//
/* Farmer vozila */
farm[1] = CreateVehicle(532, 319.9016, 1135.5984, 9.4981, 0.0000, 70, 70, 100);
farm[2] = CreateVehicle(532, 309.4786, 1135.6333, 9.4981, 0.0000, 70, 70, 100);
farm[3] = CreateVehicle(532, 298.4352, 1135.7933, 9.4981, 0.0000, 70, 70, 100);
farm[4] = CreateVehicle(531, 340.7141, 1169.8009, 8.0729, 94.0800, 70, 70, 100);
farm[5] = CreateVehicle(531, 340.9472, 1166.0431, 8.0729, 94.0800, 70, 70, 100);
farm[6] = CreateVehicle(531, 341.1888, 1162.2657, 8.0729, 94.0800, 70, 70, 100);
farm[7] = CreateVehicle(610, 354.9556, 1159.5619, 7.3228, 87.9600, 70, 70, 100);
farm[8] = CreateVehicle(610, 354.9737, 1165.9690, 7.3228, 87.9600, 70, 70, 100);
farm[9] = CreateVehicle(610, 355.1246, 1172.0917, 7.3228, 87.9600, 70, 70, 100);

farm[10] = CreateVehicle(478, 401.9136, 1160.9579, 7.7158, 178.5002, -1, -1, 100);
farm[11] = CreateVehicle(478, 406.8542, 1160.7828, 7.7158, 178.5002, -1, -1, 100);
farm[12] = CreateVehicle(478, 411.5527, 1160.6688, 7.7158, 178.5002, -1, -1, 100);
farm[13] = CreateVehicle(478, 416.3579, 1160.4718, 7.7158, 178.5002, -1, -1, 100);
farm[14] = CreateVehicle(478, 421.1357, 1161.1670, 7.7158, 178.5002, -1, -1, 100);

/* Mlijekar vozila */
milk[1] = CreateVehicle(478, 633.3325, 1254.1370, 11.5085, -60.4200, 2, 2, 100);
milk[2] = CreateVehicle(478, 635.6827, 1250.0898, 11.5085, -60.4200, 2, 2, 100);
milk[3] = CreateVehicle(478, 638.0671, 1245.9916, 11.5085, -60.4200, 2, 2, 100);
milk[4] = CreateVehicle(478, 640.4305, 1241.9275, 11.5085, -60.4200, 2, 2, 100);
milk[5] = CreateVehicle(478, 642.7318, 1237.8290, 11.5085, -60.4200, 2, 2, 100);
/* Rudar vozila */
rudar[1] = CreateVehicle(406, 309.8393, 884.1523, 21.6065, -66.6000, -1, -1, 100);
rudar[2] = CreateVehicle(406, 305.8458, 893.0388, 21.6065, -66.6000, -1, -1, 100);
rudar[3] = CreateVehicle(406, 302.2789, 901.3922, 21.6065, -66.6000, -1, -1, 100);
rudar[4] = CreateVehicle(406, 298.7455, 909.4295, 21.6065, -66.6000, -1, -1, 100);
rudar[5] = CreateVehicle(406, 295.3026, 917.5718, 21.6065, -66.6000, -1, -1, 100);
/* Postar vozila */
mail[1] = CreateVehicle(586, -135.8672, 1121.1465, 19.1888, 90.4800, 89, 89, 100);
mail[2] = CreateVehicle(586, -135.8807, 1123.2234, 19.1888, 90.4800, 89, 89, 100);
mail[3] = CreateVehicle(586, -135.8774, 1125.2977, 19.1888, 90.4800, 89, 89, 100);
mail[4] = CreateVehicle(586, -135.8413, 1127.2869, 19.1888, 90.4800, 89, 89, 100);
mail[5] = CreateVehicle(586, -135.8497, 1129.0884, 19.1888, 90.4800, 89, 89, 100);
mail[6] = CreateVehicle(586, -135.8960, 1130.9771, 19.1888, 90.4800, 89, 89, 100);
/* Elektroprivreda vozila */
eleVeh[1] = CreateVehicle(525, -48.1760, 1166.3457, 19.3923, 0.0000, -1, 89, 100);
eleVeh[2] = CreateVehicle(525, -41.1557, 1166.2922, 19.3923, 0.0000, -1, 89, 100);
eleVeh[3] = CreateVehicle(525, -34.1736, 1166.2682, 19.3923, 0.0000, -1, 89, 100);
eleVeh[4] = CreateVehicle(525, -27.2917, 1166.1709, 19.3923, 0.0000, -1, 89, 100);
eleVeh[5] = CreateVehicle(525, -23.1236, 1161.1880, 19.3923, 0.0000, -1, 89, 100);
eleVeh[6] = CreateVehicle(525, -17.3839, 1161.4000, 19.3923, 0.0000, -1, 89, 100);
eleVeh[7] = CreateVehicle(525, -12.4953, 1161.2977, 19.3923, 0.0000, -1, 89, 100);
/* Carson Army vozila */
cArmy[1] = CreateVehicle(470, 175.1196, 1457.9926, 10.2658, 180.0000, -1, -1, 100);
cArmy[2] = CreateVehicle(470, 179.4574, 1458.0358, 10.2658, 180.0000, -1, -1, 100);
cArmy[3] = CreateVehicle(470, 183.8231, 1458.0273, 10.2658, 180.0000, -1, -1, 100);
cArmy[4] = CreateVehicle(470, 188.2643, 1458.1047, 10.2658, 180.0000, -1, -1, 100);
cArmy[5] = CreateVehicle(470, 192.9048, 1458.1732, 10.2658, 180.0000, -1, -1, 100);
cArmy[6] = CreateVehicle(470, 197.2450, 1458.1775, 10.2658, 180.0000, -1, -1, 100);
cArmy[7] = CreateVehicle(433, 140.5066, 1418.0747, 10.8830, -90.0000, -1, -1, 100);
cArmy[8] = CreateVehicle(433, 140.4967, 1411.8716, 10.8830, -90.0000, -1, -1, 100);
cArmy[9] = CreateVehicle(433, 140.4554, 1405.9520, 10.8830, -90.0000, -1, -1, 100);
cArmy[10] = CreateVehicle(433, 140.5223, 1400.0347, 10.8830, -90.0000, -1, -1, 100);
cArmy[11] = CreateVehicle(433, 140.4710, 1394.3470, 10.8830, -90.0000, -1, -1, 100);
cArmy[12] = CreateVehicle(548, 145.8394, 1450.2444, 21.6807, -46.5600, -1, -1, 100);
cArmy[13] = CreateVehicle(482, 235.3449, 1384.4534, 10.5261, 0.0000, 103, 103, 100);
/* Izlozbena vozila
asCar[1] = CreateVehicle(401, -287.2658, 1325.9529, 54.1537, 82.3200, -1, -1, 100);
asCar[2] = CreateVehicle(402, -288.1453, 1321.8883, 54.0348, 81.2400, -1, -1, 100);
asCar[3] = CreateVehicle(412, -289.5875, 1317.4364, 53.9292, 81.2400, -1, -1, 100);
asCar[4] = CreateVehicle(489, -289.5552, 1312.5798, 54.2452, 82.2600, -1, -1, 100);
asCar[5] = CreateVehicle(500, -289.4529, 1307.7404, 53.9496, 81.7800, -1, -1, 100);
asCar[6] = CreateVehicle(445, -290.7870, 1303.3679, 53.7126, 81.1200, -1, -1, 100);
asCar[7] = CreateVehicle(565, -290.6672, 1298.5922, 53.3925, 82.2000, -1, -1, 100);
asCar[8] = CreateVehicle(422, -291.7313, 1294.1534, 53.5175, 82.8600, -1, -1, 100); */
//------------------------------------------------------------------------------

speedbar0 = TextDrawCreate(491.947479, 436.916717, "LD_BEAT:cring");
TextDrawLetterSize(speedbar0, 0.000000, 0.000000);
TextDrawTextSize(speedbar0, 69.341186, -78.750000);
TextDrawAlignment(speedbar0, 1);
TextDrawColor(speedbar0, -1);
TextDrawSetShadow(speedbar0, 0);
TextDrawSetOutline(speedbar0, 0);
TextDrawFont(speedbar0, 4);

speedbar1 = TextDrawCreate(555.792114, 371.333312, "usebox");
TextDrawLetterSize(speedbar1, 0.000000, 5.646297);
TextDrawTextSize(speedbar1, 550.855041, 0.000000);
TextDrawAlignment(speedbar1, 1);
TextDrawColor(speedbar1, 0);
TextDrawUseBox(speedbar1, true);
TextDrawBoxColor(speedbar1, -5963521);
TextDrawSetShadow(speedbar1, 0);
TextDrawSetOutline(speedbar1, 0);
TextDrawFont(speedbar1, 0);

speedbar2 = TextDrawCreate(558.477294, 392.000000, "LD_DUAL:rockshp");
TextDrawLetterSize(speedbar2, 0.000000, 0.000000);
TextDrawTextSize(speedbar2, 11.713072, 14.583312);
TextDrawAlignment(speedbar2, 1);
TextDrawColor(speedbar2, -1);
TextDrawSetShadow(speedbar2, 0);
TextDrawSetOutline(speedbar2, 0);
TextDrawFont(speedbar2, 4);

speedbar3 = TextDrawCreate(625.601745, 390.000000, "usebox");
TextDrawLetterSize(speedbar3, 0.000000, -0.240922);
TextDrawTextSize(speedbar3, 551.323547, 0.000000);
TextDrawAlignment(speedbar3, 1);
TextDrawColor(speedbar3, 0);
TextDrawUseBox(speedbar3, true);
TextDrawBoxColor(speedbar3, -5963521);
TextDrawSetShadow(speedbar3, 0);
TextDrawSetOutline(speedbar3, 0);
TextDrawFont(speedbar3, 0);

speedbar4 = TextDrawCreate(559.414367, 410.666656, "hud:radar_girlfriend");
TextDrawLetterSize(speedbar4, 0.000000, 0.000000);
TextDrawTextSize(speedbar4, 9.838973, 14.000020);
TextDrawAlignment(speedbar4, 1);
TextDrawColor(speedbar4, -1);
TextDrawSetShadow(speedbar4, 0);
TextDrawSetOutline(speedbar4, 0);
TextDrawFont(speedbar4, 4);

//---------- TEXTDRAWS: SKIN SELECT -----------------------------------------//
SkinTD0 = TextDrawCreate(365.572448, 128.666656, "usebox");
TextDrawLetterSize(SkinTD0, 0.000000, 16.664815);
TextDrawTextSize(SkinTD0, 270.679290, 0.000000);
TextDrawAlignment(SkinTD0, 1);
TextDrawColor(SkinTD0, 51);
TextDrawUseBox(SkinTD0, true);
TextDrawBoxColor(SkinTD0, 353703423);
TextDrawSetShadow(SkinTD0, 1);
TextDrawSetOutline(SkinTD0, 0);
TextDrawFont(SkinTD0, 0);

SkinTD1 = TextDrawCreate(280.175659, 125.999984, "KAUBOJ");
TextDrawLetterSize(SkinTD1, 0.449999, 1.600000);
TextDrawTextSize(SkinTD1, 357.481964, 36.750030);
TextDrawAlignment(SkinTD1, 1);
TextDrawColor(SkinTD1, -1);
TextDrawSetShadow(SkinTD1, 0);
TextDrawUseBox(SkinTD1, true);
TextDrawBoxColor(SkinTD1, 353703168);
TextDrawSetOutline(SkinTD1, 1);
TextDrawBackgroundColor(SkinTD1, 51);
TextDrawFont(SkinTD1, 2);
TextDrawSetProportional(SkinTD1, 1);

SkinTD2 = TextDrawCreate(273.147857, 143.500000, "LD_SPAC:white");
TextDrawLetterSize(SkinTD2, 0.000000, 0.000000);
TextDrawTextSize(SkinTD2, 89.956085, 137.083312);
TextDrawAlignment(SkinTD2, 1);
TextDrawColor(SkinTD2, -1);
TextDrawUseBox(SkinTD2, 1);
TextDrawBoxColor(SkinTD2, 0);
TextDrawSetShadow(SkinTD2, 0);
TextDrawSetOutline(SkinTD2, 0);
TextDrawFont(SkinTD2, 5);
TextDrawBackgroundColor(SkinTD5, 0);
TextDrawSetPreviewModel(SkinTD2, 33);
TextDrawSetPreviewRot(SkinTD2, 345.000000, 0.000000, 0.000000, 1.000000);

SkinTD3 = TextDrawCreate(269.525390, 144.008361, "usebox");
TextDrawLetterSize(SkinTD3, 0.000000, 16.664815);
TextDrawTextSize(SkinTD3, 174.163986, 0.000000);
TextDrawAlignment(SkinTD3, 1);
TextDrawColor(SkinTD3, 0);
TextDrawUseBox(SkinTD3, true);
TextDrawBoxColor(SkinTD3, 353703423);
TextDrawSetShadow(SkinTD3, 0);
TextDrawSetOutline(SkinTD3, 0);
TextDrawFont(SkinTD3, 0);

SkinTD4 = TextDrawCreate(183.051269, 140.933349, "FARMER");
TextDrawLetterSize(SkinTD4, 0.449999, 1.600000);
TextDrawTextSize(SkinTD4, 263.777526, 5.250000);
TextDrawAlignment(SkinTD4, 1);
TextDrawColor(SkinTD4, -1);
TextDrawSetShadow(SkinTD4, 0);
TextDrawSetOutline(SkinTD4, 1);
TextDrawUseBox(SkinTD4, true);
TextDrawBoxColor(SkinTD4, 353703168);
TextDrawBackgroundColor(SkinTD4, 51);
TextDrawFont(SkinTD4, 2);
TextDrawSetProportional(SkinTD4, 1);

SkinTD5 = TextDrawCreate(176.632507, 154.000000, "LD_SPAC:white");
TextDrawLetterSize(SkinTD5, 0.000000, 0.000000);
TextDrawTextSize(SkinTD5, 91.361633, 142.333312);
TextDrawAlignment(SkinTD5, 1);
TextDrawColor(SkinTD5, -1);
TextDrawUseBox(SkinTD5, true);
TextDrawBoxColor(SkinTD5, 0);
TextDrawSetShadow(SkinTD5, 0);
TextDrawSetOutline(SkinTD5, 0);
TextDrawFont(SkinTD5, 5);
TextDrawSetPreviewModel(SkinTD5, 161);
TextDrawBackgroundColor(SkinTD5, 0);
TextDrawSetPreviewRot(SkinTD5, 0.000000, 0.000000, 0.000000, 1.000000);

SkinTD6 = TextDrawCreate(461.338439, 144.066528, "usebox");
TextDrawLetterSize(SkinTD6, 0.000000, 16.729631);
TextDrawTextSize(SkinTD6, 365.976745, 0.000000);
TextDrawAlignment(SkinTD6, 1);
TextDrawColor(SkinTD6, 0);
TextDrawUseBox(SkinTD6, true);
TextDrawBoxColor(SkinTD6, 353703423);
TextDrawSetShadow(SkinTD6, 0);
TextDrawSetOutline(SkinTD6, 0);
TextDrawFont(SkinTD6, 0);

SkinTD7 = TextDrawCreate(372.005767, 142.333374, "BESKUCNIK");
TextDrawLetterSize(SkinTD7, 0.366696, 1.622749);
TextDrawTextSize(SkinTD7, 454.934143, 17.500000);
TextDrawAlignment(SkinTD7, 1);
TextDrawColor(SkinTD7, -1);
TextDrawSetShadow(SkinTD7, 0);
TextDrawSetOutline(SkinTD7, 1);
TextDrawUseBox(SkinTD7, true);
TextDrawBoxColor(SkinTD7, 353703168);
TextDrawBackgroundColor(SkinTD7, 51);
TextDrawFont(SkinTD7, 2);
TextDrawSetProportional(SkinTD7, 1);

SkinTD8 = TextDrawCreate(368.726196, 157.500000, "LD_SPAC:white");
TextDrawLetterSize(SkinTD8, 0.000000, 0.000000);
TextDrawTextSize(SkinTD8, 91.361663, 139.416687);
TextDrawAlignment(SkinTD8, 1);
TextDrawColor(SkinTD8, -1);
TextDrawUseBox(SkinTD8, true);
TextDrawBoxColor(SkinTD8, 0);
TextDrawSetShadow(SkinTD8, 0);
TextDrawSetOutline(SkinTD8, 0);
TextDrawFont(SkinTD8, 5);
TextDrawSetPreviewModel(SkinTD8, 78);
TextDrawBackgroundColor(SkinTD5, 0);
TextDrawSetPreviewRot(SkinTD8, 0.000000, 0.000000, 0.000000, 1.000000);

SkinTD9 = TextDrawCreate(313.191925, 105.566658, "usebox");
TextDrawLetterSize(SkinTD9, 0.000000, 1.627776);
TextDrawTextSize(SkinTD9, 213.941390, 0.000000);
TextDrawAlignment(SkinTD9, 1);
TextDrawColor(SkinTD9, 0);
TextDrawUseBox(SkinTD9, true);
TextDrawBoxColor(SkinTD9, 353703423);
TextDrawSetShadow(SkinTD9, 0);
TextDrawSetOutline(SkinTD9, 0);
TextDrawFont(SkinTD9, 0);

SkinTD10 = TextDrawCreate(217.393814, 104.416648, "Fort Carson");
TextDrawLetterSize(SkinTD10, 0.449999, 1.600000);
TextDrawTextSize(SkinTD10, 311.566680, 8.500000);
TextDrawAlignment(SkinTD10, 1);
TextDrawColor(SkinTD10, -1);
TextDrawSetShadow(SkinTD10, 0);
TextDrawSetOutline(SkinTD10, 1);
TextDrawUseBox(SkinTD10, true);
TextDrawBoxColor(SkinTD10, 353703168);
TextDrawBackgroundColor(SkinTD10, 51);
TextDrawFont(SkinTD10, 1);
TextDrawSetProportional(SkinTD10, 1);

SkinTD11 = TextDrawCreate(427.323883, 105.158332, "usebox");
TextDrawLetterSize(SkinTD11, 0.000000, 1.692592);
TextDrawTextSize(SkinTD11, 314.204925, 0.000000);
TextDrawAlignment(SkinTD11, 1);
TextDrawColor(SkinTD11, 0);
TextDrawUseBox(SkinTD11, true);
TextDrawBoxColor(SkinTD11, 353703423);
TextDrawSetShadow(SkinTD11, 0);
TextDrawSetOutline(SkinTD11, 0);
TextDrawFont(SkinTD11, 0);

SkinTD12 = TextDrawCreate(318.734893, 104.416648, "Las Barrancas");
TextDrawLetterSize(SkinTD12, 0.449999, 1.600000);
TextDrawTextSize(SkinTD12, 428.228485, 8.416666);
TextDrawAlignment(SkinTD12, 1);
TextDrawColor(SkinTD12, -1);
TextDrawUseBox(SkinTD12, true);
TextDrawBoxColor(SkinTD12, 353703168);
TextDrawSetShadow(SkinTD12, 0);
TextDrawSetOutline(SkinTD12, 1);
TextDrawBackgroundColor(SkinTD12, 51);
TextDrawFont(SkinTD12, 1);
TextDrawSetProportional(SkinTD12, 1);

SkinTD13 = TextDrawCreate(204.275207, 86.333343, "Odaberite spawn i skin");
TextDrawLetterSize(SkinTD13, 0.449999, 1.600000);
TextDrawAlignment(SkinTD13, 1);
TextDrawColor(SkinTD13, -5963521);
TextDrawSetShadow(SkinTD13, 0);
TextDrawSetOutline(SkinTD13, 1);
TextDrawBackgroundColor(SkinTD13, 51);
TextDrawFont(SkinTD13, 2);
TextDrawSetProportional(SkinTD13, 1);

SkinTD14 = TextDrawCreate(365.572265, 303.374664, "usebox");
TextDrawLetterSize(SkinTD14, 0.000000, -2.411792);
TextDrawTextSize(SkinTD14, 270.632446, 0.000000);
TextDrawAlignment(SkinTD14, 1);
TextDrawColor(SkinTD14, 0);
TextDrawUseBox(SkinTD14, true);
TextDrawBoxColor(SkinTD14, 656877567);
TextDrawSetShadow(SkinTD14, 0);
TextDrawSetOutline(SkinTD14, 0);
TextDrawFont(SkinTD14, 0);

SkinTD15 = TextDrawCreate(274.553466, 284.666687, "KRENI IGRATI");
TextDrawLetterSize(SkinTD15, 0.325232, 1.612250);
TextDrawTextSize(SkinTD15, 365.915130, 15.750002);
TextDrawAlignment(SkinTD15, 1);
TextDrawColor(SkinTD15, -5963521);
TextDrawSetShadow(SkinTD15, 0);
TextDrawUseBox(SkinTD15, true);
TextDrawBoxColor(SkinTD15, 353703168);
TextDrawSetOutline(SkinTD15, 1);
TextDrawBackgroundColor(SkinTD15, 51);
TextDrawFont(SkinTD15, 2);
TextDrawSetProportional(SkinTD15, 1);
//---------- TEXTDRAWS: LOADING / WELCOME -----------------------------------//
	Welcome0 = TextDrawCreate(643.250000, 1.500000, "usebox");
	TextDrawLetterSize(Welcome0, 0.000000, 9.130090);
	TextDrawTextSize(Welcome0, -5.125000, 0.000000);
	TextDrawAlignment(Welcome0, 1);
	TextDrawColor(Welcome0, 0);
	TextDrawUseBox(Welcome0, true);
	TextDrawBoxColor(Welcome0, 255);
	TextDrawSetShadow(Welcome0, 0);
	TextDrawSetOutline(Welcome0, 0);
	TextDrawFont(Welcome0, 0);

	Welcome1 = TextDrawCreate(675.125000, 377.166687, "usebox");
	TextDrawLetterSize(Welcome1, 0.000000, 7.655553);
	TextDrawTextSize(Welcome1, -3.250000, 0.000000);
	TextDrawAlignment(Welcome1, 1);
	TextDrawColor(Welcome1, 0);
	TextDrawUseBox(Welcome1, true);
	TextDrawBoxColor(Welcome1, 255);
	TextDrawSetShadow(Welcome1, 0);
	TextDrawSetOutline(Welcome1, 0);
	TextDrawFont(Welcome1, 0);

	Welcome2 = TextDrawCreate(180.125000, 27.749998, "usebox");
	TextDrawLetterSize(Welcome2, 0.000000, 39.349994);
	TextDrawTextSize(Welcome2, -4.500000, 0.000000);
	TextDrawAlignment(Welcome2, 1);
	TextDrawColor(Welcome2, 0);
	TextDrawUseBox(Welcome2, true);
	TextDrawBoxColor(Welcome2, 255);
	TextDrawSetShadow(Welcome2, 0);
	TextDrawSetOutline(Welcome2, 0);
	TextDrawFont(Welcome2, 0);

	Welcome3 = TextDrawCreate(642.625000, 70.333335, "usebox");
	TextDrawLetterSize(Welcome3, 0.000000, 39.674068);
	TextDrawTextSize(Welcome3, 491.125000, 0.000000);
	TextDrawAlignment(Welcome3, 1);
	TextDrawColor(Welcome3, 0);
	TextDrawUseBox(Welcome3, true);
	TextDrawBoxColor(Welcome3, 255);
	TextDrawSetShadow(Welcome3, 0);
	TextDrawSetOutline(Welcome3, 0);
	TextDrawFont(Welcome3, 0);

	Welcome4 = TextDrawCreate(265.750000, 310.666687, "usebox");
	TextDrawLetterSize(Welcome4, 0.000000, 7.720366);
	TextDrawTextSize(Welcome4, 163.625000, 0.000000);
	TextDrawAlignment(Welcome4, 1);
	TextDrawColor(Welcome4, 0);
	TextDrawUseBox(Welcome4, true);
	TextDrawBoxColor(Welcome4, 255);
	TextDrawSetShadow(Welcome4, 0);
	TextDrawSetOutline(Welcome4, 0);
	TextDrawFont(Welcome4, 0);

	Welcome5 = TextDrawCreate(275.125000, 75.000000, "usebox");
	TextDrawLetterSize(Welcome5, 0.000000, 34.424076);
	TextDrawTextSize(Welcome5, 259.250000, 0.000000);
	TextDrawAlignment(Welcome5, 1);
	TextDrawColor(Welcome5, 0);
	TextDrawUseBox(Welcome5, true);
	TextDrawBoxColor(Welcome5, 255);
	TextDrawSetShadow(Welcome5, 0);
	TextDrawSetOutline(Welcome5, 0);
	TextDrawFont(Welcome5, 0);

	Welcome6 = TextDrawCreate(358.875000, 252.333328, "usebox");
	TextDrawLetterSize(Welcome6, 0.000000, 13.942593);
	TextDrawTextSize(Welcome6, 265.500000, 0.000000);
	TextDrawAlignment(Welcome6, 1);
	TextDrawColor(Welcome6, 0);
	TextDrawUseBox(Welcome6, true);
	TextDrawBoxColor(Welcome6, 255);
	TextDrawSetShadow(Welcome6, 0);
	TextDrawSetOutline(Welcome6, 0);
	TextDrawFont(Welcome6, 0);

	Welcome7 = TextDrawCreate(367.000000, 83.166671, "usebox");
	TextDrawLetterSize(Welcome7, 0.000000, 33.646289);
	TextDrawTextSize(Welcome7, 353.000000, 0.000000);
	TextDrawAlignment(Welcome7, 1);
	TextDrawColor(Welcome7, 0);
	TextDrawUseBox(Welcome7, true);
	TextDrawBoxColor(Welcome7, 255);
	TextDrawSetShadow(Welcome7, 0);
	TextDrawSetOutline(Welcome7, 0);
	TextDrawFont(Welcome7, 0);

	Welcome8 = TextDrawCreate(498.875000, 278.583312, "usebox");
	TextDrawLetterSize(Welcome8, 0.000000, 14.007410);
	TextDrawTextSize(Welcome8, 351.125000, 0.000000);
	TextDrawAlignment(Welcome8, 1);
	TextDrawColor(Welcome8, 0);
	TextDrawUseBox(Welcome8, true);
	TextDrawBoxColor(Welcome8, 255);
	TextDrawSetShadow(Welcome8, 0);
	TextDrawSetOutline(Welcome8, 0);
	TextDrawFont(Welcome8, 0);

	Welcome9 = TextDrawCreate(509.500000, 70.916671, "usebox");
	TextDrawLetterSize(Welcome9, 0.000000, 26.257404);
	TextDrawTextSize(Welcome9, 443.625000, 0.000000);
	TextDrawAlignment(Welcome9, 1);
	TextDrawColor(Welcome9, 0);
	TextDrawUseBox(Welcome9, true);
	TextDrawBoxColor(Welcome9, 255);
	TextDrawSetShadow(Welcome9, 0);
	TextDrawSetOutline(Welcome9, 0);
	TextDrawFont(Welcome9, 0);

	Welcome10 = TextDrawCreate(265.000000, 250.250030, "Skripter:");
	TextDrawLetterSize(Welcome10, 0.449999, 1.600000);
	TextDrawAlignment(Welcome10, 1);
	TextDrawColor(Welcome10, -5963521);
	TextDrawSetShadow(Welcome10, 0);
	TextDrawSetOutline(Welcome10, 1);
	TextDrawBackgroundColor(Welcome10, 51);
	TextDrawFont(Welcome10, 0);
	TextDrawSetProportional(Welcome10, 1);

	Welcome11 = TextDrawCreate(281.875000, 264.250000, "Nikky");
	TextDrawLetterSize(Welcome11, 0.449999, 1.600000);
	TextDrawAlignment(Welcome11, 1);
	TextDrawColor(Welcome11, -1);
	TextDrawSetShadow(Welcome11, 0);
	TextDrawSetOutline(Welcome11, 1);
	TextDrawBackgroundColor(Welcome11, 51);
	TextDrawFont(Welcome11, 2);
	TextDrawSetProportional(Welcome11, 1);

	Welcome12 = TextDrawCreate(213.125000, 45.500003, "VINTAGE REPUBLIC RPG/DM");
	TextDrawLetterSize(Welcome12, 0.612500, 3.845833);
	TextDrawAlignment(Welcome12, 1);
	TextDrawColor(Welcome12, -5963521);
	TextDrawSetShadow(Welcome12, 0);
	TextDrawSetOutline(Welcome12, 1);
	TextDrawBackgroundColor(Welcome12, 51);
	TextDrawFont(Welcome12, 0);
	TextDrawSetProportional(Welcome12, 1);

	Welcome13 = TextDrawCreate(365.000000, 277.083343, "www.vintage-republic.ga");
	TextDrawLetterSize(Welcome13, 0.146247, 1.115833);
	TextDrawAlignment(Welcome13, 1);
	TextDrawColor(Welcome13, -1);
	TextDrawSetShadow(Welcome13, 0);
	TextDrawSetOutline(Welcome13, 1);
	TextDrawBackgroundColor(Welcome13, 51);
	TextDrawFont(Welcome13, 2);
	TextDrawSetProportional(Welcome13, 1);

	Welcome14 = TextDrawCreate(266.250000, 281.750000, "Map made by:");
	TextDrawLetterSize(Welcome14, 0.449999, 1.600000);
	TextDrawAlignment(Welcome14, 1);
	TextDrawColor(Welcome14, -5963521);
	TextDrawSetShadow(Welcome14, 0);
	TextDrawSetOutline(Welcome14, 1);
	TextDrawBackgroundColor(Welcome14, 51);
	TextDrawFont(Welcome14, 0);
	TextDrawSetProportional(Welcome14, 1);

	Welcome15 = TextDrawCreate(273.750000, 296.916748, "NIKKY & PaVa");
	TextDrawLetterSize(Welcome15, 0.324999, 1.827499);
	TextDrawAlignment(Welcome15, 1);
	TextDrawColor(Welcome15, -1);
	TextDrawSetShadow(Welcome15, 0);
	TextDrawSetOutline(Welcome15, 1);
	TextDrawBackgroundColor(Welcome15, 51);
	TextDrawFont(Welcome15, 2);
	TextDrawSetProportional(Welcome15, 1);
//---------- TEXTDRAWS: LOADING / WELCOME GOTOVO ----------------------------//
tdbar0 = TextDrawCreate(2.811095, 433.416595, "[VR:RPG]");
TextDrawLetterSize(tdbar0, 0.275709, 1.279165);
TextDrawAlignment(tdbar0, 1);
TextDrawColor(tdbar0, -5963521);
TextDrawSetShadow(tdbar0, 0);
TextDrawSetOutline(tdbar0, 1);
TextDrawBackgroundColor(tdbar0, 51);
TextDrawFont(tdbar0, 1);
TextDrawSetProportional(tdbar0, 1);

tdbar1 = TextDrawCreate(52.005874, 433.416687, "Vintage Republic je u BETA fazi. Sve bugove prijavite na forum!");
TextDrawLetterSize(tdbar1, 0.350203, 1.378332);
TextDrawAlignment(tdbar1, 1);
TextDrawColor(tdbar1, -1061109505);
TextDrawSetShadow(tdbar1, 0);
TextDrawSetOutline(tdbar1, 1);
TextDrawBackgroundColor(tdbar1, 51);
TextDrawFont(tdbar1, 2);
TextDrawSetProportional(tdbar1, 1);

tdbar2 = TextDrawCreate(39.950218, 431.416625, "usebox");
TextDrawLetterSize(tdbar2, 0.000000, -0.410369);
TextDrawTextSize(tdbar2, -0.594435, 0.000000);
TextDrawAlignment(tdbar2, 1);
TextDrawColor(tdbar2, 0);
TextDrawUseBox(tdbar2, true);
TextDrawBoxColor(tdbar2, -5963521);
TextDrawSetShadow(tdbar2, 0);
TextDrawSetOutline(tdbar2, 0);
TextDrawFont(tdbar2, 0);

tdbar3 = TextDrawCreate(14.650072, 419.749969, "usebox");
TextDrawLetterSize(tdbar3, 0.000000, 0.659444);
TextDrawTextSize(tdbar3, 0.811127, 0.000000);
TextDrawAlignment(tdbar3, 1);
TextDrawColor(tdbar3, 0);
TextDrawUseBox(tdbar3, true);
TextDrawBoxColor(tdbar3, 102);
TextDrawSetShadow(tdbar3, 0);
TextDrawSetOutline(tdbar3, 0);
TextDrawFont(tdbar3, 0);

tdbar4 = TextDrawCreate(14.650074, 407.500000, "usebox");
TextDrawLetterSize(tdbar4, 0.000000, 0.684447);
TextDrawTextSize(tdbar4, 0.811128, 0.000000);
TextDrawAlignment(tdbar4, 1);
TextDrawColor(tdbar4, 0);
TextDrawUseBox(tdbar4, true);
TextDrawBoxColor(tdbar4, 102);
TextDrawSetShadow(tdbar4, 0);
TextDrawSetOutline(tdbar4, 0);
TextDrawFont(tdbar4, 0);


	ShowPlayerMarkers(0);
	ShowNameTags(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetNameTagDrawDistance(10.0);

	TextDrawSetSelectable(SkinTD1, true);
	TextDrawSetSelectable(SkinTD4, true);
	TextDrawSetSelectable(SkinTD7, true);
	TextDrawSetSelectable(SkinTD10, true);
	TextDrawSetSelectable(SkinTD12, true);
	TextDrawSetSelectable(SkinTD15, true);
	// =========== TIMERS ===========
	SetTimer("JailArea", 1000, true);
	SetTimer("MoneyUpdate",1000,1);
	//SetTimer("SaveAccounts", SECONDS(13), 1);
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0); // Without this you'll be kicked when you spawn. Set it to wherever you want.
	SetPlayerCameraPos(playerid, -637.2444, 2693.7332, 73.7816);
	SetPlayerCameraLookAt(playerid, -638.2198, 2693.9377, 73.7211);
	TogglePlayerSpectating(playerid, true);
	SetTimerEx("FixPlayerCam", 100, 0, "i", playerid);
	return 1;
}
//////////////////////////////////////////////
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == SkinTD15){
	if(GetPVarInt(playerid, "odabrao_spawn") != 0){
	if(GetPVarInt(playerid, "odabrao_skin") != 0){
	TogglePlayerSpectating(playerid, 0);
	TextDrawHideForPlayer(playerid, SkinTD0);
	TextDrawHideForPlayer(playerid, SkinTD1);
	TextDrawHideForPlayer(playerid, SkinTD2);
	TextDrawHideForPlayer(playerid, SkinTD3);
	TextDrawHideForPlayer(playerid, SkinTD4);
	TextDrawHideForPlayer(playerid, SkinTD5);
	TextDrawHideForPlayer(playerid, SkinTD6);
	TextDrawHideForPlayer(playerid, SkinTD7);
	TextDrawHideForPlayer(playerid, SkinTD8);
	TextDrawHideForPlayer(playerid, SkinTD9);
	TextDrawHideForPlayer(playerid, SkinTD10);
	TextDrawHideForPlayer(playerid, SkinTD11);
	TextDrawHideForPlayer(playerid, SkinTD12);
	TextDrawHideForPlayer(playerid, SkinTD13);
	TextDrawHideForPlayer(playerid, SkinTD14);
	TextDrawHideForPlayer(playerid, SkinTD15);
	SetPlayerPos(playerid, PlayerInfo[playerid][pSpawnX], PlayerInfo[playerid][pSpawnY], PlayerInfo[playerid][pSpawnZ]);
	SetCameraBehindPlayer(playerid);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Ako zelite promijeniti spawn ukucajte "STRING_WHITE"/changespawn");
	ShowPlayerDialog(playerid, DIALOG_ID_REZOLUCIJA, DIALOG_STYLE_MSGBOX, "Preporuka", ""STRING_YELLOW"Preporucujemo igru na "STRING_RED"1024x768"STRING_YELLOW" rezoluciji ali preporucljiva je i veca. Ako koristite manju rezoluciju, "STRING_RED"textdraw-ovi"STRING_YELLOW" nece biti\ndobro prikazani.", "Shvatio", "");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste odabrali skin! Kliknite na ime skina da odaberete."); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste odabrali spawn mjesto!"); }
	}
	if(clickedid == SkinTD12){
	SendClientMessage(playerid, COLOR_YELLOW, "Odabrali ste Las Barrancas kao spawn!");
	PlayerInfo[playerid][pSpawnX] = -795.5369;
	PlayerInfo[playerid][pSpawnY] = 1557.2480;
	PlayerInfo[playerid][pSpawnZ] = 27.1244;
	SetPVarInt(playerid, "odabrao_spawn", 1);
	}
	if(clickedid == SkinTD10){
	SendClientMessage(playerid, COLOR_YELLOW, "Odabrali ste Fort Carson kao spawn!");
	PlayerInfo[playerid][pSpawnX] = -795.5369;
	PlayerInfo[playerid][pSpawnY] = 1557.2480;
	PlayerInfo[playerid][pSpawnZ] = 27.1244;
	SetPVarInt(playerid, "odabrao_spawn", 1);
	}
	if(clickedid == SkinTD7){
	SendClientMessage(playerid, COLOR_YELLOW, "Odabrali ste beskucnika kao vas skin!");
	PlayerInfo[playerid][pSkin] = 78;
	SetPVarInt(playerid, "odabrao_skin", 1);
	}
	if(clickedid == SkinTD4){
	SendClientMessage(playerid, COLOR_YELLOW, "Odabrali ste farmera kao vas skin!");
	PlayerInfo[playerid][pSkin] = 161;
	SetPVarInt(playerid, "odabrao_skin", 1);
	}
	if(clickedid == SkinTD1){
	SendClientMessage(playerid, COLOR_YELLOW, "Odabrali ste kauboja kao vas skin!");
	PlayerInfo[playerid][pSkin] = 33;
	SetPVarInt(playerid, "odabrao_skin", 1);
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_ATELEPORT_ORG){
	if(response){
	if(listitem == 0){
	SetPlayerPos(playerid, 165.7628,1441.3352,10.5912);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do Carson Army organizacije.");
	}
	if(listitem == 1){
	SetPlayerPos(playerid, -154.4720,1093.8916,19.5938);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do Sheriff Department organizacije.");
	}
	if(listitem == 2){
	SetPlayerPos(playerid, -72.1923,1364.2179,10.0691);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do Vagos Gang organizacije.");
	}
	if(listitem == 3){
	SetPlayerPos(playerid, 120.3238,1091.7582,13.6094);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do The Vinci Family organizacije.");
	}
	}
	}
	if(dialogid == DIALOG_ATELEPORT){
	if(response){
	if(listitem == 0){
	ShowPlayerDialog(playerid, DIALOG_ATELEPORT_ORG, DIALOG_STYLE_LIST, "ADMIN TELEPORT | ODABERITE ORGANIZACIJU", "Carson Army\nSheriff Department\nVagos Gang\nVinci Family", "Teleport", "Odustani");
	}
	if(listitem == 1){
	ShowPlayerDialog(playerid, DIALOG_ATELEPORT_JOB, DIALOG_STYLE_LIST, "ADMIN TELEPORT | ODABERITE POSAO", "Elektricar\nPostar", "Teleport", "Odustani");
	}
	if(listitem == 2){
	SetPlayerPos(playerid, -89.7596,1198.9429,19.5938);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do spawna.");
	}
	if(listitem == 2){
	SetPlayerPos(playerid, -89.7596,1198.9429,19.5938);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do Fort Carson spawna.");
	}
	if(listitem == 3){
	SetPlayerPos(playerid, -808.5429,1557.2288,26.9609);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Uspjesno ste se teleportirali do Las Barrancas spawna.");
	}
	}
	}
	if(dialogid == DIALOG_DRVOSJECA){
	if(response){
	if(listitem == 0){
	if(GetPVarInt(playerid, "drvosjeca_radi") == 0){
	GivePlayerWeapon(playerid, 9, 10);
	SetPlayerCheckpoint(playerid, -516.2990, -39.0808, 59.7001, 3.0);
	SendClientMessage(playerid, COLOR_YELLOW, "Krenite sjeci drvo oznaceno na karti");
	SetPVarInt(playerid, "drvosjeca_radi", 1);
	SetPVarInt(playerid, "ostalo_udaraca", 5);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Vec imate odabranu rutu! Zavrsite ju pa onda odaberite drugu"); }
	}
	}
	}
	if(dialogid == DIALOG_BLACKMARKET){
	if(response){
		if(listitem == 0){
			if(PlayerInfo[playerid][pJob] != 6) { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti zaposleni kao "STRING_WHITE"Uzgajivac Droge"STRING_ADMWARN" da kupite sjeme."); }
			else { ShowPlayerDialog(playerid, DIALOG_SJEME, DIALOG_STYLE_INPUT, "[BLACK MARKET] - Sjeme", "Unesite koliko vrecica sjemena zelite kupiti.\nCijena vrecice je $50 - max 10 vrecica sjemena", "Kupi", "Odustani"); } }
		if(listitem == 1){ /* Kupi drogu */
			ShowPlayerDialog(playerid, DIALOG_KUPIDROGU, DIALOG_STYLE_INPUT, "[BLACK MARKET] - Kupi Drogu", "Unesite koliko grama droge zelite kupiti.\n1 gram = $100\nUPOZORENJE: Postoji sansa da dobijete wanted level. Kupujte kod igraca zbog sigurnosti", "Kupi", "Odustani"); }
		if(listitem == 2){ /* Prodaj drogu */
			ShowPlayerDialog(playerid, DIALOG_PRODAJDROGU, DIALOG_STYLE_INPUT, "[BLACK MARKET] - Prodaj Drogu", "Unesite koliko grama droge zelite prodati.\n1 gram = $100\nUPOZORENJE: Ako niste zaposleni kao Uzgajivac Droge mozete dobiti wanted level.\nProdajte igracu zbog sigurnosti", "Prodaj", "Odustani"); }
		if(listitem == 3){ /* Obradi drogu */
			if(PlayerInfo[playerid][pJob] != 6) { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti zaposleni kao "STRING_WHITE"Uzgajivac Droge"STRING_ADMWARN" da obradjujete drogu."); }
			else { ShowPlayerDialog(playerid, DIALOG_OBRADA, DIALOG_STYLE_INPUT, "[BLACK MARKET] - Obrada droge", "Unesite koliko grama droge zelite obraditi.", "Obradi", "Odustani"); } }
	}
	}
	if(dialogid == DIALOG_OBRADA){
	if(response){
		if(strval(inputtext) > PlayerInfo[playerid][pNovaDroga]) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate toliko neobradjene droge kod sebe.");
		PlayerInfo[playerid][pNovaDroga] = PlayerInfo[playerid][pNovaDroga]-strval(inputtext);
		PlayerInfo[playerid][pDroga] = PlayerInfo[playerid][pDroga]+strval(inputtext)-random(1);
		new obradjeno[128];
		format(obradjeno, sizeof(obradjeno), "INFO: Obradili ste %ig droge te time dobili %ig droge. Sada imate %ig.", strval(inputtext), strval(inputtext)-1, PlayerInfo[playerid][pDroga]);
		SendClientMessage(playerid, COLOR_YELLOW, obradjeno);
		if(PlayerInfo[playerid][pDroga] > 50){
	  		PlayerInfo[playerid][pDroga] = 50;
	  		SendClientMessage(playerid, COLOR_ADMWARN, "* Stavili ste previse grama droge kod sebe. Visak je bacen."); }
	}
	}
	if(dialogid == DIALOG_PRODAJDROGU){
	if(response){
		if(strval(inputtext) > PlayerInfo[playerid][pDroga]) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate toliko grama droge kod sebe.");
		PlayerInfo[playerid][pDroga] = PlayerInfo[playerid][pDroga]-strval(inputtext);
		GivePlayerCash(playerid, strval(inputtext)*100);
		new drugSold[128];
		format(drugSold, sizeof(drugSold), "INFO: Prodali ste %ig droge za $%i. Sada imate %ig kod sebe.", strval(inputtext), strval(inputtext)*100, PlayerInfo[playerid][pDroga]);
		SendClientMessage(playerid, COLOR_YELLOW, drugSold);
	}
	}
	if(dialogid == DIALOG_KUPIDROGU){
	if(response){
		if(strval(inputtext)*100 > GetPlayerCash(playerid)) { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe."); }
		else { GivePlayerMoney(playerid, -strval(inputtext)*100);
		PlayerInfo[playerid][pDroga] = PlayerInfo[playerid][pDroga]+strval(inputtext);
		new drugBought[72];
		format(drugBought, sizeof(drugBought), "INFO: Kupili ste %ig droge. Sada imate %ig kod sebe.", strval(inputtext), PlayerInfo[playerid][pDroga]);
		SendClientMessage(playerid, COLOR_YELLOW, drugBought);

		new rand = random(2);
	if(rand == 0){ /* Stavi wanted Level. TODO */ }
	  	 		}
		 	}
	}
	if(dialogid == DIALOG_SJEME){
	if(response){
		if(PlayerInfo[playerid][pSjeme]+strval(inputtext) > 10) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Mozete imati maximalno 10 vrecica sjemena kod sebe.");
		if(GetPlayerCash(playerid) < strval(inputtext)*50) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
		PlayerInfo[playerid][pSjeme] = PlayerInfo[playerid][pSjeme]+strval(inputtext);
		new seed[128];
		format(seed, sizeof(seed), "INFO: Kupili ste "STRING_WHITE"%i"STRING_YELLOW" vrecica sjemena. Sada imate "STRING_WHITE"%i", strval(inputtext), PlayerInfo[playerid][pSjeme]);
		SendClientMessage(playerid, COLOR_YELLOW, seed);
		GivePlayerCash(playerid, -50);
	}
	}
	if(dialogid == DIALOG_FARM){
	if(response){
	//----[ SIJANJE #1 ]----//
	if(listitem == 0){
  if(posijano == 0){
	if(zauzeto == 0){
	SendClientMessage(playerid, COLOR_YELLOW, "Zapoceli ste sijanje zita. Sjednite u traktor.");
	SetPVarInt(playerid, "zapoceo", 1);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Netko vec sija to zito. Odaberite drugo."); }
  }
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: To polje vec ima posijano zito!"); }
	}
	//
	if(listitem == 1){
	if(posijano == 1){
	if(zauzeto == 0){
	SendClientMessage(playerid, COLOR_YELLOW, "Zapoceli ste zetvu zita. Sjednite u kombajn.");
	SetPVarInt(playerid, "zapoceo", 1);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Netko je vec na tom polju. Odaberite drugo"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Na tom polju nije posijano zito."); }
	}
	}
	}
	if(dialogid == DIALOG_ORG_DERANK){
	if(response){
	if(PlayerInfo[strval(inputtext)][pOrg] == PlayerInfo[playerid][pOrg]){
	if(PlayerInfo[strval(inputtext)][pRank] <= 5 && PlayerInfo[strval(inputtext)][pRank] > 1){
  PlayerInfo[strval(inputtext)][pRank] = PlayerInfo[strval(inputtext)][pRank]-1;
	new rankup[82];
	format(rankup,sizeof(rankup),"INFO: Lider "STRING_RED"%s"STRING_YELLOW" vam je spustio rank na "STRING_RED"%i",Name(playerid),PlayerInfo[strval(inputtext)][pRank]);
	SendClientMessage(strval(inputtext), COLOR_YELLOW, rankup);

	if(PlayerInfo[strval(inputtext)][pRank] == 1 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 2 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 3 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 4 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 61); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 5 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 179); } //Carson Army
	//NIJE GOTOVO
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: "STRING_WHITE"Ne mozete sniziti rank tom clanu!");}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: "STRING_WHITE"Taj igrac nije u vasoj organizaciji!");}
	}
	}
	if(dialogid == DIALOG_ORG_RANK){
	if(response){
	if(PlayerInfo[strval(inputtext)][pOrg] == PlayerInfo[playerid][pOrg]){
	if(PlayerInfo[strval(inputtext)][pRank] < 5){
  PlayerInfo[strval(inputtext)][pRank] = PlayerInfo[strval(inputtext)][pRank]+1;
	new rankup[82];
	format(rankup,sizeof(rankup),"INFO: Lider "STRING_RED"%s"STRING_YELLOW" vas je unaprijedio na Rank "STRING_RED"%i",Name(playerid),PlayerInfo[strval(inputtext)][pRank]);
	SendClientMessage(strval(inputtext), COLOR_YELLOW, rankup);

	if(PlayerInfo[strval(inputtext)][pRank] == 1 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 2 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 3 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 287); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 4 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 61); } //Carson Army
	if(PlayerInfo[strval(inputtext)][pRank] == 5 && PlayerInfo[strval(inputtext)][pOrg] == 1){ SetPlayerSkin(playerid, 179); } //Carson Army
	//NIJE GOTOVO
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: "STRING_WHITE"Taj igrac je vec najveci rank koji moze biti!");}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: "STRING_WHITE"Taj igrac nije u vasoj organizaciji!");}
	}
	}
	if(dialogid == DIALOG_ORG_KICK){
	if(response){
	if(PlayerInfo[strval(inputtext)][pOrg] == PlayerInfo[playerid][pOrg]){
	PlayerInfo[sit][pOrg] = 0;
	if(PlayerInfo[sit][pSex] == 1) { SetPlayerSkin(playerid, 33); }
	if(PlayerInfo[sit][pSex] == 2) { SetPlayerSkin(playerid, 198); }
	SendClientMessage(sit, COLOR_YELLOW, "INFO: "STRING_WHITE"Izbaceni ste iz vase organizacije!");
	new izbacio[64];
	format(izbacio,sizeof(izbacio),"INFO: "STRING_WHITE"Izbacili ste igraca "STRING_RED"%s"STRING_WHITE" iz vase organizacije.",Name(sit));
	SendClientMessage(playerid, COLOR_YELLOW, izbacio);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: "STRING_WHITE"Taj igrac nije u vasoj organizaciji!");}
  }
	}
	if(dialogid == DIALOG_INVITE_PONUDA){
	if(response){
	if(PlayerInfo[playerid][pOrg] == 0){
	PlayerInfo[playerid][pOrg] = PlayerInfo[GetPVarInt(playerid, "inviteLider")][pOrg];
	if(PlayerInfo[playerid][pOrg] == 1){ SetPlayerSkin(playerid, 287);}
	if(PlayerInfo[playerid][pOrg] == 2){ SetPlayerSkin(playerid, 284);}
	if(PlayerInfo[playerid][pOrg] == 3){ SetPlayerSkin(playerid, 28); }
	if(PlayerInfo[playerid][pOrg] == 4){ SetPlayerSkin(playerid, 108);}
	new prihvatio[128];
	format(prihvatio,sizeof(prihvatio),"INFO:"STRING_WHITE"Igrac "STRING_RED"%s"STRING_WHITE" je prihvatio vas poziv! Sada je clan vase organizacije.",Name(playerid));
	SendClientMessage(GetPVarInt(playerid, "inviteLider"), COLOR_YELLOW, prihvatio);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: "STRING_WHITE"Prihvatili ste poziv za organizaciju! Postavljen vam je novi skin.");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Vec ste clan jedne organizacije."); }
	}
	}
	if(dialogid == DIALOG_INVITE){
	if(response){
	SetPVarInt(playerid, "inviteID", strval(inputtext));
	SetPVarInt(strval(inputtext), "inviteLider", playerid);
	new Float:x1, Float:y1, Float:z1;
	GetPlayerPos(strval(inputtext), x1, y1, z1);
	if(IsPlayerInRangeOfPoint(playerid, 6.0, x1, y1, z1)){
	new ponuda[150];
	new orga[32];
	if(PlayerInfo[playerid][pOrg] == 1){ orga = "Carson Army"; }
	if(PlayerInfo[playerid][pOrg] == 2){ orga = "Sherrif Department"; }
	if(PlayerInfo[playerid][pOrg] == 3){ orga = "Street Tigers"; }
	if(PlayerInfo[playerid][pOrg] == 4){ orga = "Vagos Gang"; }
	format(ponuda,sizeof(ponuda),""STRING_WHITE"Lider "STRING_RED"%s"STRING_WHITE" organizacije "STRING_RED"%s"STRING_WHITE" vam je poslao\ninvite za tu organizaciju.", Name(playerid), orga);
	ShowPlayerDialog(strval(inputtext), DIALOG_INVITE_PONUDA, DIALOG_STYLE_MSGBOX, "Invite za organizaciju", ponuda, "Prihvati", "Odbij");
	new poslao[72];
	format(poslao,sizeof(poslao),"INFO:"STRING_WHITE" Poslali ste invite igracu "STRING_RED"%s"STRING_WHITE". Pricekajte da odgovori.", Name(strval(inputtext)));
	SendClientMessage(playerid, COLOR_YELLOW, poslao);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac nije u vasoj blizini!"); }
  }
	}
	if(dialogid == DIALOG_VEHPONUDA){
	if(response){
	if(GetPlayerCash(playerid) >= GetPVarInt(playerid, "vehSellPrice")){
	GivePlayerCash(playerid, -GetPVarInt(playerid, "vehSellPrice"));
	GivePlayerCash(GetPVarInt(playerid, "stariVlasnik"), GetPVarInt(playerid, "vehSellPrice"));
	VehicleInfo[GetPVarInt(playerid, "idVehicle")][vVlasnik] = Name(playerid);
	PlayerInfo[playerid][Car1ID] = PlayerInfo[GetPVarInt(playerid, "stariVlasnik")][Car1ID];
	PlayerInfo[GetPVarInt(playerid, "stariVlasnik")][Car1ID] = 0;
	Update3DTextLabelText(v3D[PlayerInfo[playerid][Car1ID]], COLOR_ADMWARN, Name(playerid));
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: "STRING_WHITE"Uspjesno ste kupili vozilo! Kucajte "STRING_GREEN"/veh"STRING_WHITE" da vidite komande.");
	SendClientMessage(GetPVarInt(playerid, "stariVlasnik"), COLOR_YELLOW, "INFO: "STRING_WHITE"Uspjesno ste prodali svoje vozilo! Sada ga vise nemate.");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe da kupite ovo vozilo!"); }
	}
	}
	if(dialogid == DIALOG_VEHPRODAJ2){
	if(response){
	if(strval(inputtext) >= 5000){
	SetPVarInt(GetPVarInt(playerid, "vehSellID"), "stariVlasnik", playerid);
	SetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle", VehicleInfo[PlayerInfo[playerid][Car1ID]][vID]);
	SetPVarInt(GetPVarInt(playerid, "vehSellID"), "vehSellPrice", strval(inputtext));
	new Float:x2, Float:y2, Float:z2;
	GetPlayerPos(playerid, x2, y2, z2);
	if(IsPlayerInRangeOfPoint(GetPVarInt(playerid, "vehSellID"), 6.0, x2, y2, z2)){
	new ponuda[128];
	new imeVozila[16];
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 401) { imeVozila  = "Bravura"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 402) { imeVozila  = "Buffalo"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 412) { imeVozila  = "Voodoo"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 415) { imeVozila  = "Cheetah"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 422) { imeVozila  = "Bobcat"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 466) { imeVozila  = "Glendale"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 475) { imeVozila  = "Sabre"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 489) { imeVozila  = "Rancher"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 500) { imeVozila  = "Mesa"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 445) { imeVozila  = "Admiral"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 518) { imeVozila  = "Buccaneer"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 542) { imeVozila  = "Clover"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 543) { imeVozila  = "Sadler"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 549) { imeVozila  = "Tampa"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 565) { imeVozila  = "Flash"; }
	if(GetPVarInt(GetPVarInt(playerid, "vehSellID"), "idVehicle") == 579) { imeVozila  = "Huntley"; }
	if(PlayerInfo[playerid][Car1ID] != 1){
	new ponudio[128];
	format(ponudio,sizeof(ponudio),"INFO: "STRING_WHITE"Ponudili ste prodaju vaseg vozila marke "STRING_GREEN"%s"STRING_WHITE"igracu "STRING_RED"%s", imeVozila, Name(GetPVarInt(playerid, "vehSellID")));
	SendClientMessage(playerid, COLOR_YELLOW, ponudio);
	format(ponuda,sizeof(ponuda),"Igrac "STRING_RED"%s"STRING_WHITE" vam je ponudio vozilo "STRING_GRAY"%s"STRING_WHITE" za "STRING_GREEN"$%i."STRING_WHITE"\nZelite li kupiti?", Name(GetPVarInt(playerid, "stariVlasnik")), imeVozila, GetPVarInt(GetPVarInt(playerid, "vehSellID"), "vehSellPrice"));
	ShowPlayerDialog(GetPVarInt(playerid, "vehSellID"), DIALOG_VEHPONUDA, DIALOG_STYLE_MSGBOX, "Kupnja vozila", ponuda, "Kupi", "Odustani");
  }
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac vec ima vozilo!"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac nije u vasoj blizini!"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Iznos ne smije biti manji od "STRING_GREEN"$5000"STRING_ADMWARN"!"); }
  }
  }
//============================================================================||
	if(dialogid == DIALOG_VEHPRODAJ1){
	if(response){
	SetPVarInt(playerid, "vehSellID", strval(inputtext));
	ShowPlayerDialog(playerid, DIALOG_VEHPRODAJ2, DIALOG_STYLE_INPUT, "Prodaja vozila", "Unesite iznos za koji zelite prodati vozilo.\nNe mozete ici ispod "STRING_GREEN"$5000", "Ponudi", "Odustani");
	}
  }
//============================================================================||
	if(dialogid == DIALOG_VEHBOJA2){
	if(response){
	ChangeVehicleColor(pCar, GetPVarInt(playerid, "VehColor1"), strval(inputtext));
	new vpaint[16];
	format(vpaint,sizeof(vpaint),VehiclePath, PlayerInfo[playerid][Car1ID]);
	new INI:painted = INI_Open(vpaint);
	INI_SetTag(painted,"data");
	INI_WriteInt(painted,"Boja1",GetPVarInt(playerid, "VehColor1"));
	INI_WriteInt(painted,"Boja2",strval(inputtext));
	INI_Close(painted);
	VehicleInfo[PlayerInfo[playerid][Car1ID]][vColor1] = GetPVarInt(playerid, "VehColor1");
	VehicleInfo[PlayerInfo[playerid][Car1ID]][vColor2] = strval(inputtext);
	GivePlayerCash(playerid, -500);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: "STRING_WHITE"Uspjesno ste obojali svoje vozilo!");
	}
  }
//============================================================================||
	if(dialogid == DIALOG_VEHBOJA1){
	if(response){
	SetPVarInt(playerid, "VehColor1", strval(inputtext));
	ShowPlayerDialog(playerid, DIALOG_VEHBOJA2, DIALOG_STYLE_INPUT, "Promjena boje | Color 2", "Unesite broj boje za drugu boju (Npr. 0 za crnu)\nCijena bojanja: "STRING_GREEN"$500", "Oboji", "Odustani");
	}
	}
//============================================================================||
	if(dialogid == DIALOG_VEHICLE){
	if(response){
	//----------------[ Otkljucaj/Zakljucaj ]------------------------------------|
	if(listitem == 0){
  new Float:x3, Float:y3, Float:z3;
	GetVehiclePos(idvozila[PlayerInfo[playerid][Car1ID]], x3, y3, z3);
	if(IsPlayerInRangeOfPoint(playerid, 6.0, x3, y3, z3)){
	if(VehicleInfo[PlayerInfo[playerid][Car1ID]][vLocked] == 0){
	VehicleInfo[PlayerInfo[playerid][Car1ID]][vLocked] = 1;
	new engine, lights, alarm, doors, bonnet, boot, objective;
  GetVehicleParamsEx(idvozila[PlayerInfo[playerid][Car1ID]], engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(idvozila[PlayerInfo[playerid][Car1ID]], engine, lights, alarm, VEHICLE_PARAMS_ON, bonnet, boot, objective);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Zakljucali ste svoje vozilo.");
	}
	else{
	VehicleInfo[PlayerInfo[playerid][Car1ID]][vLocked] = 0;
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Otkljucali ste svoje vozilo.");
	new engine, lights, alarm, doors, bonnet, boot, objective;
  GetVehicleParamsEx(idvozila[PlayerInfo[playerid][Car1ID]], engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(idvozila[PlayerInfo[playerid][Car1ID]], engine, lights, alarm, VEHICLE_PARAMS_OFF, bonnet, boot, objective);
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u blizini svog vozila da koristite ovu opciju.");}
	}
	//----------------[ Lociraj ]------------------------------------------------|
  if(listitem == 1){
	new Float:x4, Float:y4, Float:z4;
	GetVehiclePos(pCar, x4, y4, z4);
	SetPlayerCheckpoint(playerid, x4, y4, z4, 2.0);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO:"STRING_WHITE" Vase vozilo je oznaceno "STRING_RED"crveno"STRING_WHITE" na mapi.");
	}
	//----------------[ Parkiraj ]-----------------------------------------------|
	if(listitem == 2){
	if(IsPlayerInVehicle(playerid, pCar)){
	new Float:health;
	GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	if(health >= 700){
	new Float:x5, Float:y5, Float:z5, Float:angle, model;
	model = GetVehicleModel(pCar);
	GetVehiclePos(GetPlayerVehicleID(playerid), x5, y5, z5);
	GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
	DestroyVehicle(GetPlayerVehicleID(playerid));
	idvozila[PlayerInfo[playerid][Car1ID]] = CreateVehicle(model, x5, y5, z5, angle, VehicleInfo[PlayerInfo[playerid][Car1ID]][vColor1], VehicleInfo[PlayerInfo[playerid][Car1ID]][vColor2], 800);
	PutPlayerInVehicle(playerid, pCar, 0);
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno si parkirao svoje vozilo. Ako si ga parkirao na cesti mozes dobiti kaznu!");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Ne mozete parkirati osteceno vozilo! Popravite ga i pokusajte ponovno."); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u svom vozilu da koristite ovu komandu!"); }
	}
	//----------------[ Promijeni boju ]-----------------------------------------|
	if(listitem == 3){
	if(IsPlayerInVehicle(playerid, pCar)){
	ShowPlayerDialog(playerid, DIALOG_VEHBOJA1, DIALOG_STYLE_INPUT, "Promjena boje | Color 1", "Unesite broj boje za prvu boju (Npr. 0 za crnu)", "Sljedeca", "Odustani");
	}
	}
  //----------------[ Prodaj ]-------------------------------------------------|
	if(listitem == 4){
	new Float:x6, Float:y6, Float:z6;
	GetVehiclePos(pCar, x6, y6, z6);
	if(IsPlayerInRangeOfPoint(playerid, 6.0, x6, y6, z6)){
	ShowPlayerDialog(playerid, DIALOG_VEHPRODAJ1, DIALOG_STYLE_INPUT, "Prodaja vozila", "Unesite ID igraca kojem zelite prodati vozilo", "Dalje", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u blizini vasega vozila da ga prodate!"); }
	}

	}
	}
//============================================================================||
	if(dialogid == DIALOG_AUTOSALON){
	if(response){
	//___________________________________________||
	if(listitem == 0){ //Bravura
	if(PlayerInfo[playerid][Car1ID] == 0){
	if(GetPlayerCash(playerid) >= 15000){
	GivePlayerCash(playerid, -15000);
	for(new ips = 0; ips < MAX_VEHICLE; ips++)
	{
	new vkupljen[16];
	format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
	if(fexist(vkupljen)){
		//Nista ne radi jer taj id vozila vec postoji
	}
	else{
	if(PlayerInfo[playerid][Car1ID] == 0){
	PlayerInfo[playerid][Car1ID] = ips;
	new INI:bravura = INI_Open(vkupljen);
	INI_SetTag(bravura,"data");
	INI_WriteInt(bravura,"ID",ips);
	INI_WriteInt(bravura,"Gorivo",100);
	INI_WriteInt(bravura,"Locked",0);
	INI_WriteInt(bravura,"Vrsta",401);
	INI_WriteInt(bravura,"Boja1",0);
	INI_WriteInt(bravura,"Boja2",0);
	INI_WriteInt(bravura,"Lights",1);
	INI_WriteFloat(bravura,"ParkX",-290.8699);
	INI_WriteFloat(bravura,"ParkY",1308.2490);
	INI_WriteFloat(bravura,"ParkZ",53.9638);
	INI_WriteFloat(bravura,"Angle",82.6800);
	INI_WriteFloat(bravura,"PosX",-290.8699);
	INI_WriteFloat(bravura,"PosY",1308.2490);
	INI_WriteFloat(bravura,"PosZ",53.9638);
	INI_WriteString(bravura,"Vlasnik",Name(playerid));
	INI_WriteInt(bravura,"Kupljen",1);
	INI_Close(bravura);
	idvozila[ips] = CreateVehicle(401, -290.8699, 1308.2490, 53.9638, 82.6800, -1, -1, 800);
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
  }
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
	}
	}
//==================================================||
if(listitem == 1){ //Buffalo
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 400000){
GivePlayerCash(playerid, -400000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",402);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 2){ //Voodoo
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 35000){
GivePlayerCash(playerid, -35000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",412);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 3){ //Cheetah
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 500000){
GivePlayerCash(playerid, -500000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",415);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 4){ //Bobcat
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 55000){
GivePlayerCash(playerid, -55000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",422);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 5){ //Glendale
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 10000){
GivePlayerCash(playerid, -10000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",466);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 6){ //Sabre
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 100000){
GivePlayerCash(playerid, -100000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",475);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 7){ //Rancher
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 125000){
GivePlayerCash(playerid, -125000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",489);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 8){ //Mesa
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 135000){
GivePlayerCash(playerid, -135000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",500);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 9){ //Admiral
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 40000){
GivePlayerCash(playerid, -40000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",445);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 10){ //Buccaneer
if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 30000){
GivePlayerCash(playerid, -30000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",518);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 11){ //Clover
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 80000){
GivePlayerCash(playerid, -80000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",542);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 12){ //Sadler
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 20000){
GivePlayerCash(playerid, -20000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",543);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 13){ //Tampa
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 10000){
GivePlayerCash(playerid, -10000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",549);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 14){ //Flash
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 90000){
GivePlayerCash(playerid, -90000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",565);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
if(listitem == 15){ //Huntley
	if(PlayerInfo[playerid][Car1ID] == 0){
if(GetPlayerCash(playerid) >= 300000){
GivePlayerCash(playerid, -300000);
for(new ips = 0; ips < MAX_VEHICLE; ips++)
{
new vkupljen[16];
format(vkupljen,sizeof(vkupljen),VehiclePath, ips);
if(fexist(vkupljen)){
	//Nista ne radi jer taj id vozila vec postoji
}
else{
if(PlayerInfo[playerid][Car1ID] == 0){
PlayerInfo[playerid][Car1ID] = ips;
new INI:bravura = INI_Open(vkupljen);
INI_SetTag(bravura,"data");
INI_WriteInt(bravura,"ID",ips);
INI_WriteInt(bravura,"Gorivo",100);
INI_WriteInt(bravura,"Locked",0);
INI_WriteInt(bravura,"Vrsta",579);
INI_WriteInt(bravura,"Boja1",0);
INI_WriteInt(bravura,"Boja2",0);
INI_WriteInt(bravura,"Lights",1);
INI_WriteFloat(bravura,"ParkX",0);
INI_WriteFloat(bravura,"ParkY",0);
INI_WriteFloat(bravura,"ParkZ",0);
INI_WriteFloat(bravura,"Angle",0.0);
INI_WriteFloat(bravura,"PosX",0);
INI_WriteFloat(bravura,"PosY",0);
INI_WriteFloat(bravura,"PosZ",0);
INI_WriteString(bravura,"Vlasnik",Name(playerid));
	SendClientMessage(playerid, COLOR_GREEN, "[AUTO-SALON]: Uspjesno ste kupili auto! Ukucajte "STRING_WHITE"/veh"STRING_GREEN" te ga parkirajte.");
INI_WriteInt(bravura,"Kupljen",1);
INI_Close(bravura);
}
}
}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "AUTOSALON: Nemate dovoljno novca kod sebe da kupite to auto."); }
}
}
//==================================================||
	}
	}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	if(dialogid == DIALOG_NIGHTCLUB){
	if(response){
//___________________________________________||
  if(listitem == 0){ //Martini
	if(GetPlayerCash(playerid) < 20) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
  GivePlayerCash(playerid, -20);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+19;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+600);
	new martini[64];
	format(martini,sizeof(martini), "%s kupuje i pije Martini.", Name(playerid));
	ProxDetector(25.0, playerid, martini, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
//___________________________________________||
	if(listitem == 1){ //Mojito
	if(GetPlayerCash(playerid) < 35) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
  GivePlayerCash(playerid, -35);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+34;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+650);
	new mojito[64];
	format(mojito,sizeof(mojito), "%s kupuje i pije Mojito.", Name(playerid));
	ProxDetector(25.0, playerid, mojito, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
//___________________________________________||
	if(listitem == 2){ //Margarita
	if(GetPlayerCash(playerid) < 40) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	GivePlayerCash(playerid, -40);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+39;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+680);
	new margarita[64];
	format(margarita,sizeof(margarita), "%s kupuje i pije Margaritu.", Name(playerid));
	ProxDetector(25.0, playerid, margarita, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
//___________________________________________||
	if(listitem == 3){ //Sex on the Beach
	if(GetPlayerCash(playerid) < 50) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	GivePlayerCash(playerid, -50);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+49;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+700);
	new sotb[64];
	format(sotb,sizeof(sotb), "%s kupuje i pije Sex On The Beach.", Name(playerid));
	ProxDetector(25.0, playerid, sotb, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	if(listitem == 4){
	if(GetPlayerCash(playerid) >= 500){
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+499;
	GivePlayerCash(playerid, -500);
	SetPlayerPos(playerid, -318.8268,811.4810,-33.6299);
	SetPlayerVirtualWorld(playerid, playerid+200);
	SendClientMessage(playerid, COLOR_ADMWARN, "INFO:"STRING_GRAY" Pozovite partnera u svoju sobu komandom /pozovi");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "Nemate dovoljno novca kod sebe"); }
	}
	}
	}
	if(dialogid == DIALOG_WEAPON){
	if(response){
//___________________________________________||
	if(listitem == 0){ //Pistolj
	if(GetPlayerCash(playerid) < 250) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -250);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+249;
	GivePlayerWeapon(playerid, 22, 100);
	new pistolj[64];
	format(pistolj,sizeof(pistolj), "%s kupuje Colt45 sa 100 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, pistolj, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
//___________________________________________||
	if(listitem == 1){ //Deagle
	if(GetPlayerCash(playerid) < 300) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -300);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+299;
	GivePlayerWeapon(playerid, 24, 50);
	new deagle[64];
	format(deagle,sizeof(deagle), "%s kupuje Desert Eagle sa 50 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, deagle, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//___________________________________________||
	if(listitem == 2){ //Micro Uzi
	if(GetPlayerCash(playerid) < 900) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -900);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+899;
	GivePlayerWeapon(playerid, 28, 200);
	new uzi[64];
	format(uzi,sizeof(uzi), "%s kupuje Micro Uzi sa 200 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, uzi, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//___________________________________________||
	if(listitem == 3){ //AK47
	if(GetPlayerCash(playerid) < 3000) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -3000);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+2999;
	GivePlayerWeapon(playerid, 30, 100);
	new ak47[64];
	format(ak47,sizeof(ak47), "%s kupuje AK47 sa 200 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, ak47, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//___________________________________________||
	if(listitem == 4){ //M4
	if(GetPlayerCash(playerid) < 3000) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -3000);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+2999;
	GivePlayerWeapon(playerid, 31, 100);
	new m4[64];
	format(m4,sizeof(m4), "%s kupuje M4 sa 200 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, m4, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//___________________________________________||
	if(listitem == 5){ //Sniper
	if(GetPlayerCash(playerid) < 10000) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	SetPVarInt(playerid, "Gun", 1);
	GivePlayerCash(playerid, -10000);
	BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+9999;
	GivePlayerWeapon(playerid, 34, 30);
	new sniper[64];
	format(sniper,sizeof(sniper), "%s kupuje Sniper sa 30 metaka.", Name(playerid));
	ProxDetector(25.0, playerid, sniper, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//___________________________________________||	MOZDA DODAM JOS PUSAKA, AL ZA SADA JE DOVOLJNO
	}
	}
	if(dialogid == DIALOG_BIZNIS5){
	if(response){
 	SendClientMessage(playerid, COLOR_GREEN, "BUSINESS: Uspjesno ste kupili biznis! Da vidite komande ukucajte "STRING_WHITE"/business");
	SendClientMessage(GetPVarInt(playerid, "ovajProdaje"), COLOR_GREEN, "BUSINESS: Uspjesno ste prodali svoj biznis/firmu/tvrtku!");
	PlayerInfo[playerid][BiznisID] = PlayerInfo[GetPVarInt(playerid, "ovajProdaje")][BiznisID]; //Postavlja kupcev biznisID na prodavacev biznisID jer je kupio taj biznis
	PlayerInfo[GetPVarInt(playerid, "ovajProdaje")][BiznisID] = 0; //Postavlja prodavacev biznisID na 0 jer je prodao
	GivePlayerCash(playerid, -GetPVarInt(playerid, "ovuCijenu")); //Oduzima novac kupcu
	GivePlayerCash(GetPVarInt(playerid, "ovajProdaje"), GetPVarInt(playerid, "ovuCijenu")); //Daje novac prodavacu
//______________________________________________________________________________
BiznisInfo[PlayerInfo[playerid][BiznisID]][bVlasnik] = Name(playerid); // Postavlja vlasnika
Delete3DTextLabel(Text3D:TextNeprodano[PlayerInfo[playerid][BiznisID]]);
DestroyPickup(PickupBiznisNeprodano[PlayerInfo[playerid][BiznisID]]);


new biznisKupljeno[190];
new imeBiznisa[64];
if (BiznisInfo[PlayerInfo[playerid][BiznisID]][bTip] == 0) { imeBiznisa = "Prodavnica"; }
if (BiznisInfo[PlayerInfo[playerid][BiznisID]][bTip] == 1) { imeBiznisa = "Marketing Agencija"; }
if (BiznisInfo[PlayerInfo[playerid][BiznisID]][bTip] == 2) { imeBiznisa = "Fast Food"; }
if (BiznisInfo[PlayerInfo[playerid][BiznisID]][bTip] == 3) { imeBiznisa = "Bar"; }
if (BiznisInfo[PlayerInfo[playerid][BiznisID]][bTip] == 4) { imeBiznisa = "Restoran"; }

format(biznisKupljeno,sizeof(biznisKupljeno), ""STRING_YELLOW"--------------\n"STRING_WHITE"%s\n"STRING_YELLOW"Vlasnik: "STRING_WHITE"%s"STRING_YELLOW"\nDa udjete\npritisnite "STRING_WHITE"'F'"STRING_YELLOW"\n--------------",imeBiznisa, BiznisInfo[PlayerInfo[playerid][BiznisID]][bVlasnik]);
TextProdano[PlayerInfo[playerid][BiznisID]] = Create3DTextLabel(biznisKupljeno,-1,BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazX],BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazY],BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazZ],40.0,0,1);
PickupBiznisProdano[PlayerInfo[playerid][BiznisID]] = CreatePickup(1239,1,BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazX],BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazY],BiznisInfo[PlayerInfo[playerid][BiznisID]][bUlazZ],-1);
//______________________________________________________________________________
	}
	}
	if(dialogid == DIALOG_BIZNIS3){
	if(response){
	if(strval(inputtext) < 1000) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Cijena prodaje mora biti iznad "STRING_WHITE"$1000");
	else{
	new ponuda[64+MAX_PLAYER_NAME];
	new imeponudjenog[MAX_PLAYER_NAME];
	GetPVarString(playerid, "ProdajemBiznisIDu", imeponudjenog, sizeof(imeponudjenog));
	format(ponuda,sizeof(ponuda), "BUSINESS: Ponudili ste prodaju igracu "STRING_WHITE"%s", imeponudjenog);

	new prihvati[128];
	format(prihvati,sizeof(prihvati), ""STRING_GRAY"Igrac "STRING_ADMWARN"%s"STRING_GRAY" zeli vam prodati biznis/firmu/tvrtku za "STRING_GREEN"$%i", imeponudjenog,strval(inputtext));
	ShowPlayerDialog(GetPVarInt(playerid, "prodajemOvome"), DIALOG_BIZNIS5, DIALOG_STYLE_MSGBOX, "Kupnja biznisa/firme/tvrtke", prihvati, "Kupi", "Odustani");
	SendClientMessage(playerid, COLOR_ADMWARN, ponuda);
	SetPVarInt(GetPVarInt(playerid, "prodajemOvome"), "ovajProdaje", playerid); //Uzima ime kupca i sprema ga u kupcevu varijablu
	SetPVarInt(GetPVarInt(playerid, "prodajemOvome"), "zaOvuCijenu", strval(inputtext)); //Uzima integrer novca i sprema ga u kupcevu varijablu
	}
	}
	}
	if(dialogid == DIALOG_BIZNIS2){
	if(response){
	new ime[MAX_PLAYER_NAME];
	ime = Name(strval(inputtext));
	SetPVarString(playerid, "ProdajemBiznisIDu", ime);
	SetPVarInt(playerid, "prodajemOvome", strval(inputtext)); //Uzima ID igraca kojem prodajemo
	ShowPlayerDialog(playerid, DIALOG_BIZNIS3, DIALOG_STYLE_INPUT, "Prodaj biznis / firmu / tvrtku", "Unesite za koliko zelite prodati.", "Prodaj", "Odustani");
	}
	}
	if(dialogid == DIALOG_BIZNIS1){
	if(response){
//============================================||
	if(listitem == 0){ //Provjerava stanje u blagajni
	new blagajna[64];
	format(blagajna,sizeof(blagajna), "Trenutno stanje blagajne: "STRING_WHITE"$%i", BiznisInfo[PlayerInfo[playerid][BiznisID]][bMoney]);
	SendClientMessage(playerid, COLOR_YELLOW, blagajna);
	}
	//============================================||
	if(listitem == 1){ //Podize novac sa blagajne
	if(BiznisInfo[PlayerInfo[playerid][BiznisID]][bMoney] == 0) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate novca u blagajni.");
	else{
	GivePlayerCash(playerid,BiznisInfo[PlayerInfo[playerid][BiznisID]][bMoney]);
	new podignuto[64];
	format(podignuto,sizeof(podignuto), "Uzeli ste "STRING_WHITE"$%i "STRING_YELLOW"iz blagajne", BiznisInfo[PlayerInfo[playerid][BiznisID]][bMoney]);
	SendClientMessage(playerid, COLOR_YELLOW, podignuto);
	BiznisInfo[PlayerInfo[playerid][BiznisID]][bMoney] = 0;
  }
	}
	//============================================||
	if(listitem == 2){
	ShowPlayerDialog(playerid, DIALOG_BIZNIS2, DIALOG_STYLE_INPUT, "Prodaj biznis / firmu / tvrtku", "Unesite ID igraca kojem zelite prodati", "Dalje", "Odustani");
	}
	}
	}
//______________________________________________________________________________
	if(dialogid == DIALOG_BANKA5){
	if(response){
	if(strval(inputtext) > PlayerInfo[playerid][pBanka]) return SCM(playerid,COLOR_ADMWARN,"BANKA: Nemate toliko novca na vasem racunu.");
	else{
	PlayerInfo[playerid][pBanka] = PlayerInfo[playerid][pBanka]-strval(inputtext);
	PlayerInfo[GetPVarInt(playerid, "saljemIgracuID")][pBanka] = PlayerInfo[GetPVarInt(playerid, "saljemIgracuID")][pBanka]+strval(inputtext);
	new transfer[64];
	format(transfer,sizeof(transfer),"BANKA: Poslali ste $%i igracu %i", strval(inputtext), Name(GetPVarInt(playerid, "saljemIgracuID")));
	SendClientMessage(playerid, COLOR_ADMWARN, transfer);
	new id = GetPVarInt(playerid, "saljemIgracuID");
	new obavijest[145];
	SetPVarString(id, "daoNovac", Name(playerid));
	new imevlasnik[64];
	format(obavijest, sizeof(obavijest), "BANKA: Igrac "STRING_WHITE"%s"STRING_ADMWARN" je transferirao "STRING_WHITE"$%i"STRING_ADMWARN" na vas racun u banci.", GetPVarString(id,"daoNovac", imevlasnik,sizeof(imevlasnik)), strval(inputtext));
	SendClientMessage(id, COLOR_ADMWARN, obavijest);
	}
	}
	}
	if(dialogid == DIALOG_BANKA4){
	if(response){
	SetPVarInt(playerid, "saljemIgracuID", strval(inputtext));
	ShowPlayerDialog(playerid, DIALOG_BANKA5, DIALOG_STYLE_INPUT, "Transfer novca", "Unesite iznos novca koji zelite poslati", "Transfer", "Odustani");
	}
	}
	if(dialogid == DIALOG_BANKA3){
	if(response){
	if(strval(inputtext) > GetPlayerCash(playerid)) return SCM(playerid,COLOR_ADMWARN,"BANKA: Nemate toliko novca kod sebe.");
	if(strval(inputtext) <= GetPlayerCash(playerid)){
	PlayerInfo[playerid][pBanka] = PlayerInfo[playerid][pBanka]+strval(inputtext);
	GivePlayerCash(playerid,-strval(inputtext));
	new ostavljeno[64];
	format(ostavljeno,sizeof(ostavljeno), "BANKA: Ostavili ste "STRING_WHITE"$%i"STRING_ADMWARN" na vas racun.", strval(inputtext));
	SCM(playerid,COLOR_ADMWARN,ostavljeno);
	}
	}
	}
	if(dialogid == DIALOG_BANKA2){
	if(response){
	if(strval(inputtext) > PlayerInfo[playerid][pBanka]) return SCM(playerid,COLOR_ADMWARN,"BANKA: Nemate toliko novca na racunu.");
	if(strval(inputtext) <= PlayerInfo[playerid][pBanka]){
	PlayerInfo[playerid][pBanka] = PlayerInfo[playerid][pBanka]-strval(inputtext);
	GivePlayerCash(playerid,strval(inputtext));
	new podignuto[64];
	format(podignuto,sizeof(podignuto), "BANKA: Uzeli ste "STRING_WHITE"$%i"STRING_ADMWARN" sa vaseg racuna.", strval(inputtext));
	SCM(playerid,COLOR_ADMWARN,podignuto);
	}
	}
	}
	if(dialogid == DIALOG_BANKA){
	if(response){
	//============================================||
	if(listitem == 0){
	new stanje[64];
	format(stanje, sizeof(stanje), "Trenutno stanje na banci: "STRING_WHITE"$%i", PlayerInfo[playerid][pBanka]);
	SendClientMessage(playerid, COLOR_YELLOW, stanje);
	}
	//============================================||
	if(listitem == 1){
	ShowPlayerDialog(playerid, DIALOG_BANKA2, DIALOG_STYLE_INPUT, "Podignite novac", "Unesite iznos novca koji zelite podignuti", "Podigni","Odustani");
	}
	//============================================||
	if(listitem == 2){
	ShowPlayerDialog(playerid, DIALOG_BANKA3, DIALOG_STYLE_INPUT, "Ostavite novac", "Unesite iznos novca koji zelite ostaviti u banku", "Ostavi","Odustani");
	}
	//============================================||
	if(listitem == 3){
	ShowPlayerDialog(playerid, DIALOG_BANKA4, DIALOG_STYLE_INPUT, "Transfer novca", "Upisite id igraca kojem zelite poslati novac", "Dalje","Odustani");
	}
	//============================================||
	if(listitem == 4){
	if(PlayerInfo[playerid][pPlaca] != 0){
	GivePlayerCash(playerid, PlayerInfo[playerid][pPlaca]);
	PlayerInfo[playerid][pPlaca] = 0;
	}
	}
	}
  }
	if(dialogid == DIALOG_RESTORAN){
	if(response){
	//============================================||
	if(listitem == 0){
	if(GetPlayerCash(playerid) < 15) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+1;
	GivePlayerCash(playerid, -15);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+14; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede prsut i sir.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//============================================||
	if(listitem == 1){
	if(GetPlayerCash(playerid) < 30) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+2;
	GivePlayerCash(playerid, -30);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+29; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede juhu.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//============================================||
	if(listitem == 2){
	if(GetPlayerCash(playerid) < 35) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+3;
	GivePlayerCash(playerid, -35);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+34; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede cevape.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//============================================||
	if(listitem == 3){
	if(GetPlayerCash(playerid) < 45) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+4;
	GivePlayerCash(playerid, -45);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+44; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede krompire ispod saca.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//============================================||
	if(listitem == 4){
	if(GetPlayerCash(playerid) < 55) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+5;
	GivePlayerCash(playerid, -55);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+54; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede ribu i skampe.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	//============================================||
	if(listitem == 5){
	if(GetPlayerCash(playerid) < 100) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = 	PlayerInfo[playerid][pHrana]+10;
	GivePlayerCash(playerid, -100);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+99; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede biftek sa salatom.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	}
	}
//______________________________________________________________________________
	if(dialogid == DIALOG_DRINK){
	if(response){
//===============================================||
	if(listitem == 0){
	if(GetPlayerCash(playerid) < 15) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pVoda] = PlayerInfo[playerid][pVoda]+1;
	GivePlayerCash(playerid, -15);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+14; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i pije vodu.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_WHITE" Pice ce vam biti uklonjeno nakon 1min (/bacibocu da bacis)");
	}
//===============================================||
if(listitem == 1){
if(GetPlayerCash(playerid) < 25) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pVoda] = PlayerInfo[playerid][pVoda]+2;
GivePlayerCash(playerid, -25);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+24; }
new string[64];
format(string, sizeof(string), "%s kupuje i pije Coca Colu.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_WHITE" Pice ce vam biti uklonjeno nakon 1min (/bacibocu da bacis)");
}
//===============================================||
if(listitem == 2){
if(GetPlayerCash(playerid) < 50) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pVoda] = PlayerInfo[playerid][pVoda]+4;
SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+14000);
GivePlayerCash(playerid, -50);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+49; }
new string[64];
format(string, sizeof(string), "%s kupuje i pije Votku.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_WHITE" Pice ce vam biti uklonjeno nakon 1min (/bacibocu da bacis)");
SetTimerEx("boca", 20000, false,"i", playerid);
}
//===============================================||
if(listitem == 3){
if(GetPlayerCash(playerid) < 65) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pVoda] = PlayerInfo[playerid][pVoda]+5;
SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+15000);
GivePlayerCash(playerid, -65);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+64; }
new string[64];
format(string, sizeof(string), "%s kupuje i pije Red Label.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_WHITE" Pice ce vam biti uklonjeno nakon 20s (/bacibocu da bacis)");
SetTimerEx("boca", 20000, false,"i", playerid);
}
//===============================================||
if(listitem == 4){
if(GetPlayerCash(playerid) < 90) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pVoda] = PlayerInfo[playerid][pVoda]+5;
SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+18000);
GivePlayerCash(playerid, -90);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+89; }
new string[64];
format(string, sizeof(string), "%s kupuje i pije Viski.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_WHITE" Pice ce vam biti uklonjeno nakon 20s (/bacibocu da bacis)");
SetTimerEx("boca", 20000, false,"i", playerid);
}
//===============================================||
	}
	}
	if(dialogid == DIALOG_FASTFOOD){
	if(response){
//---------------------------------------------->
	if(listitem == 0){
	if(GetPlayerCash(playerid) < 15) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+1;
	GivePlayerCash(playerid, -15);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+14; }
	new string[64];
	format(string, sizeof(string), "%s kupuje i jede pomfrit.", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
//---------------------------------------------->
if(listitem == 1){
if(GetPlayerCash(playerid) < 30) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+2;
GivePlayerCash(playerid, -30);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+29; }
new string[64];
format(string, sizeof(string), "%s kupuje i jede Cheeseburger.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
}
//---------------------------------------------->
if(listitem == 2){
if(GetPlayerCash(playerid) < 35) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+3;
GivePlayerCash(playerid, -35);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+34; }
new string[64];
format(string, sizeof(string), "%s kupuje i jede Hamburger.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
}
//---------------------------------------------->
if(listitem == 3){
if(GetPlayerCash(playerid) < 45) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+4;
GivePlayerCash(playerid, -45);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+44; }
new string[64];
format(string, sizeof(string), "%s kupuje i jede Hamburger & Pomfrit.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
}
//---------------------------------------------->
if(listitem == 4){
if(GetPlayerCash(playerid) < 55) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+5;
GivePlayerCash(playerid, -55);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+54; }
new string[64];
format(string, sizeof(string), "%s kupuje i jede Pecenu piletinu.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
}
//---------------------------------------------->
if(listitem == 5){
if(GetPlayerCash(playerid) < 100) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
PlayerInfo[playerid][pHrana] = PlayerInfo[playerid][pHrana]+10;
GivePlayerCash(playerid, -100);
if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+99; }
new string[64];
format(string, sizeof(string), "%s kupuje i jede Obiteljski fastfood.", Name(playerid));
ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
}
//---------------------------------------------->
	}
	}
	if(dialogid == DIALOG_OGLAS){
	if(response){
	if(GetPlayerCash(playerid) >= 500){
	new oglas[128];
	format(oglas, sizeof(oglas), ""STRING_GREEN"OGLAS: %s . Kontakt: %s", inputtext, Name(playerid));
	SendClientMessageToAll(COLOR_GREEN, oglas);
	if(BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bProdano] != 0) { BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney] = BiznisInfo[GetPlayerVirtualWorld(playerid)-100][bMoney]+498; }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "Nemate dovoljno novca kod sebe (500$)!"); }
	}
	}
	if(dialogid == DIALOG_PRIHVATI){
	if(response){
	if(GetPlayerCash(playerid) >= GetPVarInt(playerid,"cijenakuce")){
	new novivlasnik[MAX_PLAYER_NAME];
	GetPlayerName(playerid,novivlasnik,sizeof(novivlasnik));
	KucaInfo[PlayerInfo[GetPVarInt(playerid,"idprodavaca")][KucaID]][kVlasnik] = novivlasnik;
	PlayerInfo[playerid][KucaID] = PlayerInfo[GetPVarInt(playerid,"idprodavaca")][KucaID];
	PlayerInfo[GetPVarInt(playerid,"idprodavaca")][KucaID] = 0;
 	Delete3DTextLabel(KucaLabelNe[PlayerInfo[playerid][KucaID]]);
 	CitajKucu(PlayerInfo[playerid][KucaID]);
	SpremiKuce(PlayerInfo[playerid][KucaID]);
	GivePlayerCash(playerid,-GetPVarInt(playerid,"cijenakuce"));
	GivePlayerCash(GetPVarInt(playerid,"idprodavaca"),GetPVarInt(playerid,"cijenakuce"));
	}
	else { SCM(playerid,COLOR_ADMWARN,"ERROR: Nemate toliko novca kod sebe."); }
	}
	}
	if(dialogid == DIALOG_SELL2){
	if(response){
	if(strval(inputtext) < 5000) return SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Ne mozete ici ispod 5000.");
	else {
	if(PlayerInfo[GetPVarInt(playerid, "idgraca")][KucaID] == 0){
	new imevlasnik[MAX_PLAYER_NAME];
	GetPVarString(playerid,"imevlasnika", imevlasnik, sizeof(imevlasnik));
	SetPVarInt(GetPVarInt(playerid, "idgraca"),"cijenakuce",strval(inputtext));
	SetPVarString(GetPVarInt(playerid, "idgraca"),"imeprodavaca",imevlasnik);
	new prodavac[128];

	new imevlasnik2[MAX_PLAYER_NAME];
 	GetPVarString(GetPVarInt(playerid, "idgraca"),"imeprodavaca",imevlasnik2,sizeof(imevlasnik2));

 	new cena = GetPVarInt(GetPVarInt(playerid,"idgraca"),"cijenakuce");
	format(prodavac,sizeof(prodavac),""STRING_GRAY"Igrac "STRING_ADMWARN"%s"STRING_GRAY" zeli vam prodati kucu za "STRING_GREEN"$%i",imevlasnik2, cena);
	ShowPlayerDialog(GetPVarInt(playerid, "idgraca"),DIALOG_PRIHVATI, DIALOG_STYLE_MSGBOX, "Kupnja kuce", prodavac, "Kupi","Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac vec ima kucu.");}
	}
	}
	}
	if(dialogid == DIALOG_SELL1){
	if(response){
    new Float:x_ds, Float:y_ds, Float:z_ds;
    GetPlayerPos(playerid, x_ds, y_ds, z_ds);
    if(IsPlayerInRangeOfPoint(strval(inputtext),5.0,x_ds,y_ds,z_ds)){
	if(PlayerInfo[strval(inputtext)][KucaID] != 0){
	SetPVarInt(playerid,"idgraca",strval(inputtext));
	new ime[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, ime, sizeof(ime));
	SetPVarString(playerid,"imevlasnika",ime);

	SetPVarInt(GetPVarInt(playerid,"idgraca"),"idprodavaca",playerid);

	ShowPlayerDialog(playerid,DIALOG_SELL2, DIALOG_STYLE_INPUT, "Prodajte kucu","Unesite za koliko novca zelite prodati.", "Prodaj", "Odustani");
	}
    else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Taj igrac vec ima kucu."); }
	}
    else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Niste u blizini tog igraca."); }
	}
	}
	if(dialogid == DIALOG_HDEPOSIT){
	if(response){
	if(strval(inputtext) < 0) return SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Nemate toliko novca kod sebe!");
	else if(strval(inputtext) > GetPlayerCash(playerid)) return SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Nemate toliko novca kod sebe!");
	else {
	KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney] = KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]+strval(inputtext);
	GivePlayerCash(playerid, -strval(inputtext));
	new ostavio[128];
	format(ostavio,sizeof(ostavio),""STRING_ADMWARN"INFO: "STRING_GRAY"Ostavili ste "STRING_GREEN"$%i"STRING_GRAY" u kucu. Sada u kuci ima:"STRING_GREEN" $%d", strval(inputtext), KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]);
	SendClientMessage(playerid,COLOR_ADMWARN,ostavio);
	}
	}
	 return 1;
	}
	if(dialogid == DIALOG_HWITHDRAW){
	if(response){
	if(strval(inputtext) < 0) return SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Nemate toliko novca u kuci!");
	else if(strval(inputtext) > KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]) return SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Nemate toliko novca u kuci!");
	else {
		KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney] = KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]-strval(inputtext);
		GivePlayerCash(playerid,strval(inputtext));
		new uzeo[128];
		format(uzeo,sizeof(uzeo),""STRING_ADMWARN"INFO: "STRING_GRAY"Uzeli ste "STRING_GREEN"$%i"STRING_GRAY" iz kuce. Preostalo vam je jos:"STRING_GREEN" $%d", strval(inputtext), KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]);
		SendClientMessage(playerid,COLOR_ADMWARN,uzeo);
	}
	}
	if(!response){
    ShowPlayerDialog( playerid, -1, 0, "","", "", "" );
	}
	  return 1;
	}
	if(dialogid == DIALOG_KUPI_TRG)
	{
	if(response){
	if(listitem == 0){
	// NIJE ZAVRSENO
	}

	}
	}
//-------------------------------------------------------------------------------
   	if(dialogid == DIALOG_AGE)
	{
	    if(!response)
       	{
         	Kick(playerid);
       	}
       	else
       	{
		    if(strlen(inputtext))
		    {
		        new age = strval(inputtext);
		        if(age > 100 || age < 16)
				{
                    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Godine -","Koliko imate godina?\n{FF0000}(( 16 - 100 ))","OK","Kick");
				}
				else
				{
					PlayerInfo[playerid][pAge] = age;
					new
						string[ 64 ]
					;
					format(string, sizeof(string), "INFO: Imas {3BB9FF}%d godina.",age);
					SendClientMessage(playerid, -1, string);
     				GivePlayerCash(playerid, 600);
					SaveAccountStats(playerid);

				TextDrawShowForPlayer(playerid, SkinTD0);
				TextDrawShowForPlayer(playerid, SkinTD1);
				TextDrawShowForPlayer(playerid, SkinTD2);
				TextDrawShowForPlayer(playerid, SkinTD3);
				TextDrawShowForPlayer(playerid, SkinTD4);
				TextDrawShowForPlayer(playerid, SkinTD5);
				TextDrawShowForPlayer(playerid, SkinTD6);
				TextDrawShowForPlayer(playerid, SkinTD7);
				TextDrawShowForPlayer(playerid, SkinTD8);
				TextDrawShowForPlayer(playerid, SkinTD9);
				TextDrawShowForPlayer(playerid, SkinTD10);
				TextDrawShowForPlayer(playerid, SkinTD11);
				TextDrawShowForPlayer(playerid, SkinTD12);
				TextDrawShowForPlayer(playerid, SkinTD13);
				TextDrawShowForPlayer(playerid, SkinTD14);
				TextDrawShowForPlayer(playerid, SkinTD15);
				//
				SelectTextDraw(playerid, 0xFF4040AA);
				}
			}
			else
			{
			    return 0;
			}
		}
	}
	if(dialogid == DIALOG_SEX)
	{
        if(response)
		{
  			PlayerInfo[playerid][pSex] = 1;
			SendClientMessage(playerid, -1, "INFO: Ti si {3BB9FF}musko.");
			SetPlayerSkin(playerid, 60);
			PlayerInfo[playerid][pSkin] = 60;
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Godine -","Koliko imate godina?\n{FF0000}(( 16 - 100 ))","OK","Kick");
		}
		else
		{
			PlayerInfo[playerid][pSex] = 2;
			SendClientMessage(playerid, -1, "INFO: Ti si {3BB9FF}zensko.");
			SetPlayerSkin(playerid, 233);
			PlayerInfo[playerid][pSkin] = 233;
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Godine -","Koliko imate godina?\n{FF0000}(( 16 - 100 ))","OK","Kick");
		}
	}
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registracija...","Unesena lozinka nije ispravna.\nUnesite lozinku da se registrirate.","Register","Kick");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Sex",0);
                INI_WriteInt(File,"Age",0);
                INI_WriteFloat(File,"Pos_x",0);
    			INI_WriteFloat(File,"Pos_y",0);
    			INI_WriteFloat(File,"Pos_z",0);
   			 	INI_WriteInt(File,"Skin",0);
   			 	INI_WriteInt(File,"Team",0);
   			 	INI_WriteInt(File,"Accent",0);
   			 	INI_WriteInt(File,"KucaID",0);
			    INI_WriteInt(File,"Hrana",10);
			    INI_WriteInt(File,"BiznisID",0);
			    INI_WriteInt(File,"Level",1);
			    INI_WriteInt(File,"Respekt",0);
			    INI_WriteInt(File,"Do_Respekta",0);
			    INI_WriteInt(File,"Oruzje",0);
			    INI_WriteInt(File,"Letenje",0);
			    INI_WriteInt(File,"Kazne",0);
			    INI_WriteInt(File,"Organizacija",0);
			    INI_WriteInt(File,"Rank",0);
			    INI_WriteInt(File,"OrgSati",0);
			    INI_WriteInt(File,"Dostave",0);
			    INI_WriteInt(File,"Posao",0);
			    INI_WriteInt(File,"Skill",0);
			    INI_WriteInt(File,"JobUgovor",0);
			    INI_WriteInt(File,"Placa",0);
			    INI_WriteInt(File,"Car1",0);
			    INI_WriteInt(File,"Car2",0);
			    INI_WriteInt(File,"Cigarete",0);
			    INI_WriteInt(File,"Kredit",0);
			    INI_WriteInt(File,"OCN",0);
					INI_WriteInt(File,"Placa",0);

                INI_Close(File);

                ShowPlayerDialog(playerid, DIALOG_SEX, DIALOG_STYLE_MSGBOX, "- Spol -","Odaberite svoj spol.","Musko","Zensko");
            }
        }
        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    new
                        tmp2[ 256 ],
                        playername2[ MAX_PLAYER_NAME ]
					;
	    			GetPlayerName(playerid, playername2, sizeof(playername2));
   					format(tmp2, sizeof(tmp2), "~w~Dobrodosli ~n~~g~%s", playername2);
					GameTextForPlayer(playerid, tmp2, 5000, 1);

					TextDrawHideForPlayer(playerid, Welcome0);
					TextDrawHideForPlayer(playerid, Welcome1);
					TextDrawHideForPlayer(playerid, Welcome2);
					TextDrawHideForPlayer(playerid, Welcome3);
					TextDrawHideForPlayer(playerid, Welcome4);
					TextDrawHideForPlayer(playerid, Welcome5);
					TextDrawHideForPlayer(playerid, Welcome6);
					TextDrawHideForPlayer(playerid, Welcome7);
					TextDrawHideForPlayer(playerid, Welcome8);
					TextDrawHideForPlayer(playerid, Welcome9);
					TextDrawHideForPlayer(playerid, Welcome10);
					TextDrawHideForPlayer(playerid, Welcome11);
					TextDrawHideForPlayer(playerid, Welcome12);
					TextDrawHideForPlayer(playerid, Welcome13);
					TextDrawHideForPlayer(playerid, Welcome14);
					TextDrawHideForPlayer(playerid, Welcome15);

          GivePlayerCash(playerid, PlayerInfo[playerid][pCash]);
   				SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
					SpawnPlayer(playerid);
				}
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,"Login",""STRING_ADMWARN"//------------------------------------//"STRING_WHITE"\n\n"STRING_RED"UPOZORENJE: "STRING_WHITE"Netocna lozinka!\n\nUnesite lozinku da krenete s igrom\n\n"STRING_ADMWARN"//------------------------------------//","Login","Kick");
                }
                return 1;
            }
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
  if(IsPlayerConnected(playerid))
	{
    	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    	SetPlayerToTeamColor(playerid);
    	Logged[playerid] = 1;
			TogglePlayerSpectating(playerid, 0);
			SetCameraBehindPlayer(playerid);
     	SetPlayerPos(playerid, PlayerInfo[playerid][pSpawnX], PlayerInfo[playerid][pSpawnY], PlayerInfo[playerid][pSpawnZ]);

     	TextDrawShowForPlayer(playerid, tdbar0);
     	TextDrawShowForPlayer(playerid, tdbar1);
     	TextDrawShowForPlayer(playerid, tdbar2);
     	TextDrawShowForPlayer(playerid, tdbar3);
     	TextDrawShowForPlayer(playerid, tdbar4);
			PlayerTextDrawShow(playerid, tdbar5[playerid]);
			PlayerTextDrawShow(playerid, tdbar6[playerid]);


     	//SetTimerEx("VrijemeHrana", 6000, true, "i", playerid);
	}
}

public OnPlayerText(playerid, text[])
{
	new string[128];
	if(IsPlayerConnected(playerid))
	{
		if(callchat[playerid] == 1)
		{
		format(string, sizeof(string), "%s (Mobitel): %s", Name(playerid), text);
		ProxDetector(10.0, playerid, string, COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

		SendClientMessage(GetPVarInt(playerid, "zovem_id"), COLOR_YELLOW, string);
		}
		if(realchat[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAccent] == 0)
			{
				format(string, sizeof(string), "%s kaze: %s", RPName(playerid), text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			}
			else
			{
				new
					accent[20]
				;
				switch(PlayerInfo[playerid][pAccent])
				{
					case 1: accent = "Ruski";
					case 2: accent = "Talijanski";
					case 3: accent = "Njemacki";
					case 4: accent = "Japanski";
					case 5: accent = "Francuski";
					case 6: accent = "Spanjolski";
					case 7: accent = "Kineski";
					case 8: accent = "Engleski";
				}
				format(string, sizeof(string), "%s kaze: [%s naglasak] %s", RPName(playerid), accent, text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			}
			return 0;
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveAccountStats(playerid);
	SpremiIgracKucu(playerid);
    return 1;
}

function SetPlayerToTeamColor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    SetPlayerColor(playerid,TEAM_HIT_COLOR);
	}
}

function OOCOff(color,const string[])
{
	foreach (Player,i)
	{
		if(!gOoc{i})
		{
			SendClientMessage(i, color, string);
		}
	}
}

function SaveAccountStats(playerid)
{
	if(Logged[playerid] == 1)
	{
	new
		INI:File = INI_Open(UserPath(playerid))
	;
    INI_SetTag(File,"data");

   	PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
    PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
   	new
	   	Float:x_d,
	    Float:y_d,
		Float:z_d
	;
	GetPlayerPos(playerid,x_d,y_d,z_d);
	PlayerInfo[playerid][pPos_x] = x_d;
	PlayerInfo[playerid][pPos_y] = y_d;
	PlayerInfo[playerid][pPos_z] = z_d;

    INI_WriteInt(File,"Cash",PlayerInfo[playerid][pCash]);
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Sex",PlayerInfo[playerid][pSex]);
    INI_WriteInt(File,"Age",PlayerInfo[playerid][pAge]);
    INI_WriteFloat(File,"Pos_x",PlayerInfo[playerid][pPos_x]);
    INI_WriteFloat(File,"Pos_y",PlayerInfo[playerid][pPos_y]);
    INI_WriteFloat(File,"Pos_z",PlayerInfo[playerid][pPos_z]);
    INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
    INI_WriteInt(File,"Team",PlayerInfo[playerid][pTeam]);
    INI_WriteInt(File,"Accent",PlayerInfo[playerid][pAccent]);
    INI_WriteInt(File,"KucaID",PlayerInfo[playerid][KucaID]);
    INI_WriteInt(File,"Hrana",PlayerInfo[playerid][pHrana]);
    INI_WriteInt(File,"BiznisID",PlayerInfo[playerid][BiznisID]);
    INI_WriteInt(File,"Level",PlayerInfo[playerid][pLevel]);
    INI_WriteInt(File,"Respekt",PlayerInfo[playerid][pRespekt]);
    INI_WriteInt(File,"Do_Respekta",PlayerInfo[playerid][pDoRespekta]);
    INI_WriteInt(File,"Oruzje",PlayerInfo[playerid][pOruzje]);
    INI_WriteInt(File,"Letenje",PlayerInfo[playerid][pLetenje]);
    INI_WriteInt(File,"Kazne",PlayerInfo[playerid][pKazne]);
    INI_WriteInt(File,"Organizacija",PlayerInfo[playerid][pOrg]);
    INI_WriteInt(File,"Rank",PlayerInfo[playerid][pRank]);
    INI_WriteInt(File,"OrgSati",PlayerInfo[playerid][OrgSati]);
    INI_WriteInt(File,"Dostave",PlayerInfo[playerid][OrgDostave]);
    INI_WriteInt(File,"Posao",PlayerInfo[playerid][pJob]);
    INI_WriteInt(File,"Skill",PlayerInfo[playerid][JobSkill]);
    INI_WriteInt(File,"JobUgovor",PlayerInfo[playerid][JobUgovor]);
    INI_WriteInt(File,"Placa",PlayerInfo[playerid][JobPlaca]);
    INI_WriteInt(File,"Car1",PlayerInfo[playerid][Car1ID]);
    INI_WriteInt(File,"Car2",PlayerInfo[playerid][Car2ID]);
    INI_WriteInt(File,"Cigarete",PlayerInfo[playerid][pCigarete]);
    INI_WriteInt(File,"Kredit",PlayerInfo[playerid][pKredit]);
    INI_WriteInt(File,"OCN",PlayerInfo[playerid][pOCN]);
    INI_WriteInt(File,"Banka",PlayerInfo[playerid][pBanka]);
    INI_WriteInt(File,"Duty",PlayerInfo[playerid][pDuty]);
    INI_WriteInt(File,"Voda",PlayerInfo[playerid][pVoda]);
		INI_WriteInt(File,"Placa",PlayerInfo[playerid][JobPlaca]);
		INI_WriteInt(File,"Sjeme", PlayerInfo[playerid][pSjeme]);
		INI_WriteInt(File,"Droga", PlayerInfo[playerid][pDroga]);
		INI_WriteInt(File,"NeobradjenaDroga", PlayerInfo[playerid][pNovaDroga]);
		INI_WriteInt(File,"Mobitel", PlayerInfo[playerid][pMob]);
		INI_WriteFloat(File,"SpawnX", PlayerInfo[playerid][pSpawnX]);
		INI_WriteFloat(File,"SpawnY", PlayerInfo[playerid][pSpawnY]);
		INI_WriteFloat(File,"SpawnZ", PlayerInfo[playerid][pSpawnZ]);
    INI_Close(File);
    }
    return 1;
}

function SaveAccounts()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SaveAccountStats(i);
  		}
	}
}

function GameModeExitFunc()
{
 	GameModeExit();
	return 1;
}
function LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Sex",PlayerInfo[playerid][pSex]);
    INI_Int("Age",PlayerInfo[playerid][pAge]);
    INI_Float("Pos_x",PlayerInfo[playerid][pPos_x]);
    INI_Float("Pos_y",PlayerInfo[playerid][pPos_y]);
    INI_Float("Pos_z",PlayerInfo[playerid][pPos_z]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
    INI_Int("Team",PlayerInfo[playerid][pTeam]);
    INI_Int("Accent",PlayerInfo[playerid][pAccent]);
    INI_Int("KucaID",PlayerInfo[playerid][KucaID]);
    INI_Int("Hrana",PlayerInfo[playerid][pHrana]);
    INI_Int("BiznisID",PlayerInfo[playerid][BiznisID]);
    INI_Int("Level",PlayerInfo[playerid][pLevel]);
    INI_Int("Respekt",PlayerInfo[playerid][pRespekt]);
    INI_Int("Do_Respekta",PlayerInfo[playerid][pDoRespekta]);
    INI_Int("Oruzje",PlayerInfo[playerid][pOruzje]);
    INI_Int("Letenje",PlayerInfo[playerid][pLetenje]);
    INI_Int("Kazne",PlayerInfo[playerid][pKazne]);
    INI_Int("Organizacija",PlayerInfo[playerid][pOrg]);
    INI_Int("Rank",PlayerInfo[playerid][pRank]);
    INI_Int("OrgSati",PlayerInfo[playerid][OrgSati]);
    INI_Int("Dostave",PlayerInfo[playerid][OrgDostave]);
    INI_Int("Posao",PlayerInfo[playerid][pJob]);
    INI_Int("Skill",PlayerInfo[playerid][JobSkill]);
    INI_Int("JobUgovor",PlayerInfo[playerid][JobUgovor]);
    INI_Int("Placa",PlayerInfo[playerid][JobPlaca]);
    INI_Int("Car1",PlayerInfo[playerid][Car1ID]);
    INI_Int("Car2",PlayerInfo[playerid][Car2ID]);
    INI_Int("Cigarete",PlayerInfo[playerid][pCigarete]);
    INI_Int("Kredit",PlayerInfo[playerid][pKredit]);
    INI_Int("OCN",PlayerInfo[playerid][pOCN]);
    INI_Int("Banka",PlayerInfo[playerid][pBanka]);
    INI_Int("Duty",PlayerInfo[playerid][pDuty]);
    INI_Int("Voda",PlayerInfo[playerid][pVoda]);
    INI_Int("Placa",PlayerInfo[playerid][JobPlaca]);
		INI_Int("Sjeme", PlayerInfo[playerid][pSjeme]);
		INI_Int("Droga", PlayerInfo[playerid][pDroga]);
		INI_Int("NeobradjenaDroga", PlayerInfo[playerid][pNovaDroga]);
		INI_Int("Mobitel", PlayerInfo[playerid][pMob]);
		INI_Float("SpawnX", PlayerInfo[playerid][pSpawnX]);
		INI_Float("SpawnY", PlayerInfo[playerid][pSpawnY]);
		INI_Float("SpawnZ", PlayerInfo[playerid][pSpawnZ]);
    return 1;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function  JailArea(playerid)
{
	if(PlayerInfo[playerid][pArea] == 1){
	if(PlayerInfo[playerid][pAreaMin] != 0){
		if(PlayerInfo[playerid][pAreaSec] != 0){
		PlayerInfo[playerid][pAreaSec]--;
		new area[32];
		format(area, sizeof(area), "AREA: %dmin i %ds", PlayerInfo[playerid][pAreaMin], PlayerInfo[playerid][pAreaSec]);
		PlayerTextDrawSetString(playerid, AreaJailTD0[playerid], area);
		}
		else {
			PlayerInfo[playerid][pAreaSec] = 59;
			PlayerInfo[playerid][pAreaMin]--;
			new area[32];
			format(area, sizeof(area), "AREA: %dmin i %ds", PlayerInfo[playerid][pAreaMin], PlayerInfo[playerid][pAreaSec]);
			PlayerTextDrawSetString(playerid, AreaJailTD0[playerid], area);
		}
	}
	else{
	SetPlayerPos(playerid, PlayerInfo[playerid][pSpawnX], PlayerInfo[playerid][pSpawnY], PlayerInfo[playerid][pSpawnZ]);
	SendClientMessage(playerid, COLOR_ADMWARN, "SERVER: Vasa kazna je istekla pa ste pusteni. Sada pazite kako se ponasate.");
	PlayerInfo[playerid][pAreaMin] = 0;
	PlayerInfo[playerid][pAreaSec] = 0;
	PlayerInfo[playerid][pArea] = 0;
	PlayerTextDrawHide(playerid, AreaJailTD0[playerid]);
	}
	}
	return 1;
}
function MoneyUpdate(playerid)
{
	if(GetPlayerCash(playerid) < GetPlayerMoney(playerid))
	{
		foreach(Player, i)
		{
  			new const old_money = GetPlayerCash(playerid);
    		ResetPlayerCash(playerid), GivePlayerCash(playerid, old_money);
   		}
	}
 	return 1;
}

function ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new BigEar[MAX_PLAYERS];
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

// ============ STOCKS ============
stock GetPlayerIdFromName(playername[])
{
  for(new i = 0; i <= MAX_PLAYERS; i++)
  {
    if(IsPlayerConnected(i))
    {
      new playername2[MAX_PLAYER_NAME];
      GetPlayerName(i, playername2, sizeof(playername2));
      if(strcmp(playername2, playername, true, strlen(playername)) == 0)
      {
        return i;
      }
    }
  }
  return INVALID_PLAYER_ID;
}

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

stock GetVehicleName(vehicleid)
{
	new String[16];
	format(String,sizeof(String),"%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
	return String;
}
stock CitajVehicle(ips)
{
	idvozila[ips] = CreateVehicle(VehicleInfo[ips][vTip], VehicleInfo[ips][vParkX], VehicleInfo[ips][vParkY], VehicleInfo[ips][vParkZ], VehicleInfo[ips][vAngle], VehicleInfo[ips][vColor1], VehicleInfo[ips][vColor2], 800, 0);
	v3D[ips] = Create3DTextLabel(VehicleInfo[ips][vVlasnik], COLOR_ADMWARN, 0.0, 0.0, 0.0, 50.0, 0, 1);
	Attach3DTextLabelToVehicle(v3D[ips], idvozila[ips], 0, 0, 0.0);
}
stock CitajDrogu(ipd)
{
	new DrogaText[170];
	if(DrogaInfo[ipd][dZauzeto] == 0) { PickupDrogaUntaken[ipd] = CreatePickup(1279, 1, DrogaInfo[ipd][dPosX], DrogaInfo[ipd][dPosY], DrogaInfo[ipd][dPosZ], -1);
	TextDrogaUntaken[ipd] = CreateDynamic3DTextLabel(""STRING_YELLOW"Vlasnik: Nitko\nKucajte "STRING_WHITE"/sadidrogu\n"STRING_YELLOW"da posadite", COLOR_YELLOW, DrogaInfo[ipd][dPosX], DrogaInfo[ipd][dPosY], DrogaInfo[ipd][dPosZ], 15.0);
	SetDynamicObjectPos(drogaObject[ipd], DrogaInfo[ipd][dPosX], DrogaInfo[ipd][dPosY], 0.0);
	}

	else{ format(DrogaText, sizeof(DrogaText), "Vlasnik: "STRING_YELLOW"%s\n"STRING_RED"Kucajte "STRING_WHITE"/beridrogu\n"STRING_RED"da uberete", DrogaInfo[ipd][dVlasnik]);
	TextDrogaTaken[ipd] = Create3DTextLabel(DrogaText, COLOR_RED, DrogaInfo[ipd][dPosX], DrogaInfo[ipd][dPosY], DrogaInfo[ipd][dPosZ], 15.0,0,1);
	SetDynamicObjectPos(drogaObject[ipd], DrogaInfo[ipd][dPosX], DrogaInfo[ipd][dPosY], 84.1898600);
	}
}
stock CitajBiznis(ipy)
{
	if (BiznisInfo[ipy][bProdano] == 0) { PickupBiznisNeprodano[ipy] = CreatePickup(1272,1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],-1); }
	if (BiznisInfo[ipy][bProdano] == 1) { PickupBiznisProdano[ipy] = CreatePickup(1239,1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],-1); }

	new biznisNEProdano[190];

	new biznisKupljeno[190];
	new imeBiznisa[64];
	if (BiznisInfo[ipy][bTip] == 0) { imeBiznisa = "Prodavnica"; }
	if (BiznisInfo[ipy][bTip] == 1) { imeBiznisa = "Marketing Agencija"; }
	if (BiznisInfo[ipy][bTip] == 2) { imeBiznisa = "Fast Food"; }
	if (BiznisInfo[ipy][bTip] == 3) { imeBiznisa = "Bar"; }
	if (BiznisInfo[ipy][bTip] == 4) { imeBiznisa = "Restoran"; }
	if (BiznisInfo[ipy][bTip] == 5) { imeBiznisa = "Banka"; }
	if (BiznisInfo[ipy][bTip] == 6) { imeBiznisa = "Oruzarnica"; }
	if (BiznisInfo[ipy][bTip] == 7) { imeBiznisa = "Nocni Klub"; }
	if (BiznisInfo[ipy][bTip] == 8) { imeBiznisa = "Sex Shop"; }
	if (BiznisInfo[ipy][bTip] == 9) { imeBiznisa = "Skin Shop"; }
	if (BiznisInfo[ipy][bTip] == 10) { imeBiznisa = "Pumpa"; }

	format(biznisNEProdano,sizeof(biznisNEProdano), ""STRING_LJUBIC"--------------\n[ %s ] na prodaju\nCijena: "STRING_WHITE"$%i\n"STRING_LJUBIC"Kucajte "STRING_WHITE"/kupitvrtku"STRING_LJUBIC" da kupite\n--------------", imeBiznisa, BiznisInfo[ipy][bCijena]);
	if(BiznisInfo[ipy][bProdano] == 0) { TextNeprodano[ipy] = Create3DTextLabel(biznisNEProdano,-1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],40.0,0,1); }

	format(biznisKupljeno,sizeof(biznisKupljeno), ""STRING_YELLOW"--------------\n"STRING_WHITE"[ %s ]\n"STRING_YELLOW"Vlasnik:"STRING_WHITE"%s"STRING_YELLOW"\nDa udjete u tvrtku\npritisnite "STRING_WHITE"'F'"STRING_YELLOW"\n--------------",imeBiznisa, BiznisInfo[ipy][bVlasnik]);
	if(BiznisInfo[ipy][bProdano] == 1) { TextProdano[ipy] = Create3DTextLabel(biznisKupljeno,-1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],40.0,0,1); }
}
stock Name(playerid)
{
	new nname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nname, sizeof(nname));
	return nname;
}
stock SpremiIgracKucu(playerid)
{
    new string[64];
    format(string, sizeof(string), "Kuce/%i.ini", PlayerInfo[playerid][KucaID]);
	new INI:SaveI = INI_Open(string);
	INI_SetTag(SaveI,"data");
	INI_WriteInt(SaveI,"Locked",KucaInfo[PlayerInfo[playerid][KucaID]][kLocked]);
	INI_WriteInt(SaveI,"Oruzje",KucaInfo[PlayerInfo[playerid][KucaID]][kOruzje]);
	INI_WriteInt(SaveI,"Prodano",KucaInfo[PlayerInfo[playerid][KucaID]][kProdano]);
	INI_WriteString(SaveI,"Vlasnik",KucaInfo[PlayerInfo[playerid][KucaID]][kVlasnik]);
	INI_WriteInt(SaveI,"Novac",KucaInfo[PlayerInfo[playerid][KucaID]][kMoney]);
	INI_WriteInt(SaveI,"Ammo",KucaInfo[PlayerInfo[playerid][KucaID]][kAmmo]);
	INI_Close(SaveI);

}
stock SpremiBiznise(b)
{
	new string[128];
	format(string, sizeof(string), "Biznisi/%i.ini", b);
	new INI:SaveB = INI_Open(string);
	INI_SetTag(SaveB,"biznis");
	INI_WriteInt(SaveB,"Blagajna",BiznisInfo[b][bMoney]);
	INI_WriteInt(SaveB,"Prodano",BiznisInfo[b][bProdano]);
	INI_WriteString(SaveB,"Vlasnik",BiznisInfo[b][bVlasnik]);
	INI_Close(SaveB);
}
stock SpremiVehicle(v)
{
	new vstring[128];
	format(vstring, sizeof(vstring), VehiclePath, v);
	new INI:SaveV = INI_Open(vstring);
	INI_SetTag(SaveV,"data");
	INI_WriteInt(SaveV,"Boja1",VehicleInfo[v][vColor1]);
	INI_WriteInt(SaveV,"Boja2",VehicleInfo[v][vColor2]);
	INI_WriteInt(SaveV,"Kupljen",VehicleInfo[v][vKupljen]);
	INI_WriteInt(SaveV,"lights",VehicleInfo[v][vLight]);
	INI_WriteFloat(SaveV,"ParkX",VehicleInfo[v][vParkX]);
	INI_WriteFloat(SaveV,"ParkY",VehicleInfo[v][vParkY]);
	INI_WriteFloat(SaveV,"ParkZ",VehicleInfo[v][vParkZ]);
	INI_WriteFloat(SaveV,"Angle",VehicleInfo[v][vAngle]);
	INI_WriteFloat(SaveV,"PosX",VehicleInfo[v][vPosX]);
	INI_WriteFloat(SaveV,"PosY",VehicleInfo[v][vPosY]);
	INI_WriteFloat(SaveV,"PosZ",VehicleInfo[v][vPosZ]);
	INI_WriteString(SaveV,"Vlasnik",VehicleInfo[v][vVlasnik]);
	INI_WriteInt(SaveV,"Gorivo",VehicleInfo[v][vFuel]);
	INI_WriteInt(SaveV,"Locked",VehicleInfo[v][vLocked]);
	INI_Close(SaveV);
}
stock SpremiKuce(k)
{
    new string[128];
    format(string, sizeof(string), "Kuce/%i.ini", k);
	new INI:SaveH = INI_Open(string);
	INI_SetTag(SaveH,"data");
	INI_WriteInt(SaveH,"Locked",KucaInfo[k][kLocked]);
	INI_WriteInt(SaveH,"Oruzje",KucaInfo[k][kOruzje]);
	INI_WriteInt(SaveH,"Prodano",KucaInfo[k][kProdano]);
	INI_WriteString(SaveH,"Vlasnik",KucaInfo[k][kVlasnik]);
	INI_WriteInt(SaveH,"Novac",KucaInfo[k][kMoney]);
	INI_WriteInt(SaveH,"Ammo",KucaInfo[k][kAmmo]);
	INI_Close(SaveH);

}
stock CitajKucu(ipx)
{
//______________________________________________________________________________
	if (KucaInfo[ipx][kProdano] == 0) { KucaPickupNe[ipx] = CreatePickup(1273,1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],-1); }
	if (KucaInfo[ipx][kProdano] == 1) { KucaPickupDa[ipx] = CreatePickup(19522,1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],-1); }

	new neprodana[128];
	format(neprodana,sizeof(neprodana), "-----------\nKuca je na prodaju\nCijena: "STRING_GREEN"%i"STRING_GRAY"\nKucajte "STRING_GREEN"/kupikucu"STRING_GRAY" da kupite\n-----------",KucaInfo[ipx][kCijena]);
	if (KucaInfo[ipx][kProdano] == 0) { KucaLabelNe[ipx] = Create3DTextLabel(neprodana,-1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],15.0,0,1); }

	new prodana[128];
	format(prodana,sizeof(prodana), "-----------\nVlasnik kuce: "STRING_ADMWARN"%s\nDa udjete u kucu\npritisnite "STRING_ADMWARN"'F'\n-----------", KucaInfo[ipx][kVlasnik]);
	if (KucaInfo[ipx][kProdano] == 1) { KucaLabelDa[ipx] = Create3DTextLabel(prodana,-1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],15.0,0,0); }
//______________________________________________________________________________
}
stock SendAdminMessage( color, string[] )
{
    foreach (Player,i)
    {
		if( PlayerInfo[ i] [ pAdmin ] > 1 )
		{
		    SendClientMessage( i, color, string );
		}
    }
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}
/* Credits to Dracoblue */
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
//????????????????????????????????????????????
stock SendToAdmins(COLOR,message[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
     	if(PlayerInfo[i][pAdmin] > 1)
     	{
      		SendClientMessage(i,COLOR,message);
     	}
	}
}
//--------------------------------------------
stock RPName(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    new str[24];
    strmid(str,string,0,strlen(string),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (str[i] == '_') str[i] = ' ';
    }
    return str;
}
// =================================

/* LOGS */
function OOCLog(string[])
{
	new
		entry[ 128 ],
		year,
		month,
		day,
		hour,
		minute,
		second
	;
	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%s | (%d-%d-%d) (%d:%d:%d)\n",string, day, month, year, hour, minute, second);
	new File:hFile;
	hFile = fopen("Basic/logs/OOCLog.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

/* COMMANDS */
CMD:check(playerid, params[])
{
	new check[256], check2[256];
	new Float:x, Float:y, Float:z, Float:health, Float:armour;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	format(check, sizeof(check), "Interior: %d\nVirtal World: %i\nNovac: %d\nPozicija: X:%f - Y:%f - Z%f", GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid),x,y,z);
	format(check2, sizeof(check2), "Health: %d\nArmour: %d\nPing: %d\nVehicleID: %s", health, armour, GetPlayerPing(playerid), GetPlayerVehicleID(playerid));

	SendClientMessage(playerid, COLOR_ADMWARN, "//--------------------//");
	SendClientMessage(playerid, COLOR_YELLOW, check);
	SendClientMessage(playerid, COLOR_YELLOW, check2);
	SendClientMessage(playerid, COLOR_ADMWARN, "//--------------------//");
	return 1;
}
CMD:paydrug(playerid, params[])
{
	if(GetPVarInt(playerid, "droga_ponuda") == 1){
		SetPVarInt(playerid, "droga_ponuda", 0);
	if(GetPVarInt(playerid, "droga_cijena") > GetPlayerCash(playerid)){ //Gleda ima li igrac dovoljno novca kod sebe da kupi drogu
		SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nemate dovoljno novca kod sebe.");
	}
	else {
		GivePlayerCash(playerid, -GetPVarInt(playerid, "droga_cijena")); //Skida novac igracu koji kupuje drogu
		GivePlayerCash(GetPVarInt(playerid, "droga_diler"), GetPVarInt(playerid, "droga_cijena")); // Iako izgleda ruzno, ova linija daje novac dileru. ID se dobiva od varijable spremljene kod igraca kojem je ponudjena droga.
		PlayerInfo[playerid][pDroga] = PlayerInfo[playerid][pDroga]+GetPVarInt(playerid, "droga_kolicina"); //Daje drogu kupcu
		PlayerInfo[GetPVarInt(playerid, "droga_diler")][pDroga] = PlayerInfo[GetPVarInt(playerid, "droga_diler")][pDroga]-GetPVarInt(playerid, "droga_kolicina"); //Jos jednom ova linija izgleda ruzno ali zapravo radi. Nebi vjerovo zar ne? xD

		SendClientMessage(playerid, COLOR_YELLOW, "INFO: Uspjesno ste kupili drogu.");
		SendClientMessage(GetPVarInt(playerid, "droga_diler"), COLOR_YELLOW, "INFO: Uspjesno ste prodali drogu.");

		if(PlayerInfo[playerid][pDroga] > 50){
			PlayerInfo[playerid][pDroga] = 50;
			SendClientMessage(playerid, COLOR_ADMWARN, "* Stavili ste previse grama droge kod sebe. Visak je bacen.");
		}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Nitko vam nije ponudio drogu ili je ponuda istekla."); }
	return 1;
}
CMD:selldrug(playerid, params[])
{
	new kupac, kolicina, cijena;
	if(sscanf(params, "uii", kupac, kolicina, cijena)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /selldrug [id/ime igraca] [kolicina] [cijena]");
	new Float:k_x, Float:k_y, Float:k_z;
	GetPlayerPos(kupac, k_x, k_y, k_z);
	if(IsPlayerInRangeOfPoint(playerid, 5.0, k_x, k_y, k_z)){
		new ponuda[128];
		format(ponuda, sizeof(ponuda), "Diler %s vam je ponudio %ig droge za $%i. Ukucajte /paydrug da kupite.", Name(playerid), kolicina, cijena);
		SendClientMessage(kupac, COLOR_REPORT, ponuda);

		new selling[64];
		format(selling, sizeof(selling), "Ponudili ste %ig droge igracu %s za $%i", kolicina, Name(kupac), cijena);
		SendClientMessage(playerid, COLOR_REPORT, selling);
		SetPVarInt(playerid, "droga_ponuda", 1);
		SetPVarInt(kupac, "droga_ponuda", 1);
		SetTimerEx("droga_istek", 5000, false, "i", kupac);

		/* Postavlja informacije igracu kojem nudite drogu */
		SetPVarInt(kupac, "droga_kolicina", kolicina);
		SetPVarInt(kupac, "droga_cijena", cijena);
		SetPVarInt(kupac, "droga_diler", playerid);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste u blizini tog igraca.");}
	return 1;
}
CMD:beridrogu(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 6) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste zaposleni kao uzgajivac droge.");
	for(new did = 0; did < 11; did++){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, DrogaInfo[did][dPosX], DrogaInfo[did][dPosY], DrogaInfo[did][dPosZ])){

		if(DrogaInfo[did][dID] == PlayerInfo[playerid][DrogaID]){
			if(DrogaInfo[did][dGrown] == 1){

				DrogaInfo[did][dGrown] = 0;
				DrogaInfo[did][dVlasnik] = 0;
				DrogaInfo[did][dMinuta] = 5;
				DrogaInfo[did][dPosZ] = 0.0;
				PlayerInfo[playerid][DrogaID] = 0;
				SendClientMessage(playerid, COLOR_YELLOW, "INFO: Uspjesno ste ubrali plantazu droge te tako dobili 10g neobradjene droge.");
				PlayerInfo[playerid][pNovaDroga] = PlayerInfo[playerid][pNovaDroga]+10;
				UpdateDynamic3DTextLabelText(TextDrogaUntaken[did], COLOR_RED, ""STRING_YELLOW"Vlasnik: Nitko\nKucajte "STRING_WHITE"/sadidrogu\n"STRING_YELLOW"da posadite");

			}
			else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate sacekati da droga naraste!"); }
		}
		else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste u blizini svoje plantaze"); }
	}
	}
	return 1;
}
CMD:sadidrogu(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 6) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste zaposleni kao uzgajivac droge.");
	if(PlayerInfo[playerid][DrogaID] != 0) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Vec imate plantazu droge.");
	for(new did = 0; did < 11; did++) // did = droga id
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, DrogaInfo[did][dPosX], DrogaInfo[did][dPosY], DrogaInfo[did][dPosZ])){
		if(DrogaInfo[did][dZauzeto] == 0){
			new drogaVlasnik[172];
			format(drogaVlasnik, sizeof(drogaVlasnik), "Vlasnik: "STRING_YELLOW"%s\n"STRING_RED"Kucajte "STRING_WHITE"/beridrogu\n"STRING_RED"da uberete", Name(playerid));
			UpdateDynamic3DTextLabelText(TextDrogaUntaken[did], COLOR_RED, drogaVlasnik);
			SendClientMessage(playerid, COLOR_YELLOW, "INFO: Posadili ste drogu. Sacekajte 5 minuta da naraste.");

			DrogaInfo[did][dVlasnik] = Name(playerid);
			DrogaInfo[did][dZauzeto] = 1;
			DrogaInfo[did][dMinuta] = 5;
			PlayerInfo[playerid][DrogaID] = DrogaInfo[did][dID];
			SetTimerEx("DrogaRaste", 60000, true, "i", playerid);
		}
		else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Ta plantaza je zauzeta."); }
		}
	}
	return 1;
}
CMD:apm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti admin da koristite ovu komandu");
	if(PlayerInfo[playerid][pDuty] == 0) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti na admin duznosti da koristite ovu komandu");
	new primatelj, poruka[16];
	if(sscanf(params, "us[16]", primatelj, poruka)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /apm [id/ime igraca] [poruka]");
	if(IsPlayerConnected(primatelj)) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: To ime ne postoji ili igrac nije online.");

	new poruka2[256];
	format(poruka2, sizeof(poruka2), "Admin PM (%s) - %s.", Name(playerid), poruka);
	SendClientMessage(playerid, COLOR_YELLOW, poruka2);
	PlayerPlaySound(primatelj, 4203, 0, 0, 0);

	new poslana[256];
	format(poslana, sizeof(poslana), "(ADMIN PM) - %s. Za: %s", poruka, Name(primatelj));
	SendClientMessage(playerid, COLOR_YELLOW, poslana);
	return 1;
}
CMD:report(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /report [tekst]");
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Vase pitanje je uspjesno poslano svim online administratorima.");

	new report[170];
	format(report, sizeof(report), "## REPORT (%s) - %s ##", Name(playerid), params);
	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
	if(PlayerInfo[aon][pAdmin] > 0 && PlayerInfo[aon][pDuty] == 1){
	SendClientMessage(aon, COLOR_REPORT, report);
	}
	}
	return 1;
}
CMD:setorg(playerid, params[])
{
	new igrac, org;
	if(sscanf(params, "dd", igrac, org)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /setorg [id/ime igraca] [broj organizacije 1-4]");
	if(PlayerInfo[playerid][pAdmin] != 1337) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti admin level da korstite ovu komandu");
	if(PlayerInfo[playerid][pDuty] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti na duznosti da koristite ovu komandu.");

	PlayerInfo[igrac][pRank] = 1;
	PlayerInfo[igrac][pOrg] = org;

	new imeOrge[20];
	if(PlayerInfo[igrac][pOrg] == 1) {
	imeOrge = "Carson Army";
	SetPlayerSkin(igrac, 287); }

	if(PlayerInfo[igrac][pOrg] == 2) {imeOrge = "Sheriff Department"; 	     		 }
	if(PlayerInfo[igrac][pOrg] == 3) {imeOrge = "Carson Mafia"; 				     		 }
	if(PlayerInfo[igrac][pOrg] == 4) {imeOrge = "The Vinci Family"; 		     		 }

	new warn[128];
	format(warn, sizeof(warn), "INFO: Ubacili ste igraca %s u organizaciju %s", Name(igrac), imeOrge);
	SendClientMessage(playerid, COLOR_YELLOW, warn);
	return 1;
}
ALTCOMMAND:setleader->makeleader;
CMD:makeleader(playerid, params[])
{
	new nlider, org;
	if(sscanf(params, "dd", nlider, org)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /makeleader [id/ime igraca] [broj organizacije 1-4]");
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin level da koristite ovu komandu.");
	if(PlayerInfo[playerid][pDuty] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti na duznosti da koristite ovu komandu.");

	PlayerInfo[nlider][pRank] = 6;
	PlayerInfo[nlider][pOrg] = org;

	new imeOrge[20];
	if(PlayerInfo[nlider][pOrg] == 1) { imeOrge = "Carson Army"; 						 }
	if(PlayerInfo[nlider][pOrg] == 2) {imeOrge = "Sheriff Department"; 	     }
	if(PlayerInfo[nlider][pOrg] == 3) {imeOrge = "Carson Mafia"; 				     }
	if(PlayerInfo[nlider][pOrg] == 4) {imeOrge = "The Vinci Family"; 		     }

	new cestitamo[128];
	format(cestitamo, sizeof(cestitamo), "INFO: Admin %s vas je postavio kao lidera organizacije %s", Name(playerid), imeOrge);
	SendClientMessage(nlider, COLOR_YELLOW, cestitamo);

	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
	if(PlayerInfo[aon][pAdmin] > 0 && PlayerInfo[aon][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je postavio lidera (%s) igracu %s.", Name(playerid), imeOrge, Name(nlider));
	SendClientMessage(aon, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);
	}
	}
	return 1;
}
ALTCOMMAND:kredit->credit;
CMD:credit(playerid, params[])
{
	new stanje[64];
	format(stanje, sizeof(stanje), "ERONET: Trenutno stanje vaseg racuna: "STRING_WHITE"%d$", PlayerInfo[playerid][pKredit]);
	SendClientMessage(playerid, COLOR_YELLOW, stanje);
	return 1;
}
ALTCOMMAND:hang->hangup;
CMD:hangup(playerid, params[])
{
	if(callchat[playerid] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: Niste u pozivu.");
	callchat[playerid] = 0;
	realchat[playerid] = 1;
	callchat[GetPVarInt(playerid, "ovaj_zove")] = 0;
	realchat[GetPVarInt(playerid, "ovaj_zove")] = 1;
	SendClientMessage(playerid, COLOR_YELLOW, "ERONET: Prekinuli ste poziv.");
	SendClientMessage(GetPVarInt(playerid, "ovaj_zove"), COLOR_YELLOW, "ERONET: Poziv prekinut");
	return 1;
}
CMD:answer(playerid, params[])
{
	if(GetPVarInt(playerid, "netko_zove") != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: Nitko vas ne zove ili ste se vec javili.");
	callchat[playerid] = 1;
	realchat[playerid] = 0;
	realchat[GetPVarInt(playerid, "ovaj_zove")] = 0;
	callchat[GetPVarInt(playerid, "ovaj_zove")] = 1;
	SendClientMessage(playerid, COLOR_YELLOW, "ERONET: Javili ste se na poziv. Razgovarajte na 'T'.");
	SendClientMessage(GetPVarInt(playerid, "ovaj_zove"), COLOR_YELLOW, "ERONET: Poziv uspostavljen.");
	PlayerInfo[GetPVarInt(playerid, "ovaj_zove")][pKredit] = PlayerInfo[GetPVarInt(playerid, "ovaj_zove")][pKredit]-5;
	SetPVarInt(playerid, "netko_zove", 0);
	return 1;
}
CMD:call(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /call [id/ime igraca]");
	if(!IsPlayerConnected(strval(params))) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac ne postoji ili nije online.");
	if(PlayerInfo[playerid][pMob] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Kupite mobitel pa pokusajte ponovno");
	if(PlayerInfo[playerid][pKredit] < 5) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: Nemate dovoljno na racunu da posaljete poruku.");
	if(PlayerInfo[strval(params)][pMob] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: Taj igrac nema mobitel.");
	SetPVarInt(playerid, "zovem_id", strval(params));
	SetPVarInt(strval(params), "ovaj_zove", playerid);
	SetPVarInt(strval(params), "netko_zove", 1);

	new zovem[64];
	format(zovem, sizeof(zovem), "ERONET: Uspostava poziva prema %s ..", Name(strval(params)));
	SendClientMessage(playerid, COLOR_YELLOW, zovem);

	new poceo_zvoniti[64];
	format(poceo_zvoniti, sizeof(poceo_zvoniti), "%s mobitel je poceo zvoniti.", Name(strval(params)));
	ProxDetector(15.0, strval(params), poceo_zvoniti, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	SendClientMessage(strval(params), COLOR_YELLOW, "ERONT: Ukucajte /answer da se javite.");
	return 1;
}
CMD:sms(playerid, params[])
{
	new primatelj, poruka[16];
	if(sscanf(params, "us[16]", primatelj, poruka)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /sms [id/ime igraca] [poruka]");
	if(PlayerInfo[playerid][pMob] != 1) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Kupite mobitel pa pokusajte ponovno");
	if(PlayerInfo[playerid][pKredit] < 2) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: Nemate dovoljno na racunu da posaljete poruku.");
	if(!IsPlayerConnected(primatelj)) return SendClientMessage(playerid, COLOR_ADMWARN, "ERONET: To ime ne postoji ili igrac nije online.");

	new poruka2[256];
	format(poruka2, sizeof(poruka2), "%s. Od: %s", poruka, Name(playerid));
	SendClientMessage(primatelj, COLOR_YELLOW, poruka2);
	PlayerPlaySound(primatelj, 4203, 0, 0, 0);

	new poslana[256];
	format(poslana, sizeof(poslana), "%s. Za: %s", poruka, Name(primatelj));
	SendClientMessage(playerid, COLOR_YELLOW, poslana);

	PlayerInfo[playerid][pKredit] = PlayerInfo[playerid][pKredit]-2;
	return 1;
}
CMD:removeadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337 && PlayerInfo[playerid][pDuty] == 1){
	new adminid;
	if(sscanf(params, "u", adminid)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /removeadmin [id/ime igraca]");
	if(PlayerInfo[adminid][pAdmin] > 0){
	PlayerInfo[adminid][pAdmin] = 0;

	new removed[72];
	format(removed, sizeof(removed), "INFO: Vlasnik %s vam je skinuo admina", Name(playerid));
	SendClientMessage(adminid, COLOR_YELLOW, removed);

	new removed_info[72];
	format(removed_info, sizeof(removed_info), "INFO: Uklonili ste admina igracu %s", Name(strval(params)));
	SendClientMessage(playerid, COLOR_YELLOW, removed_info);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac nije admin!");}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337 && PlayerInfo[playerid][pDuty] == 1){
		new adminid, rank;
		if(sscanf(params, "ui", adminid, rank)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /setadmin [id/ime igraca] [rank]");

		PlayerInfo[adminid][pAdmin] = rank;

		new admin_set[72];
		format(admin_set, sizeof(admin_set), "INFO: Vlasnik %s vas je postavio kao admina R%d.", Name(playerid), rank);
		SendClientMessage(adminid, COLOR_YELLOW, admin_set);

		new owner_info[72];
		format(owner_info, sizeof(owner_info), "INFO: Postavili ste admina R%d igracu %s", rank, Name(adminid));
		SendClientMessage(playerid, COLOR_YELLOW, owner_info);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
ALTCOMMAND:offarea->oarea;
ALTCOMMAND:offlinearea->oarea;
CMD:oarea(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	new imeigraca[24], vrijeme, razlog[16];
	if(sscanf(params, "s[24]is[16]", imeigraca, vrijeme, razlog)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /oarea [puno ime igraca] [vrijeme u min] [razlog]");
	new playeracc[24];
	if(GetPlayerIdFromName(imeigraca) != INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac je online. Koristite /area komandu");
	format(playeracc, sizeof(playeracc), "Accounts/%s.ini", imeigraca);
	if(fexist(playeracc)){
	new INI:pacc = INI_Open(playeracc);
	INI_SetTag(pacc, "data");
	INI_WriteInt(pacc, "Area", 1);
	INI_WriteInt(pacc, "AreaMin", vrijeme);
	INI_WriteInt(pacc, "AreaSec", 0);
	INI_Close(pacc);

	new offline_area[128];
	format(offline_area, sizeof(offline_area), "SERVER: Admin %s je stavio igraca %s (offline) u areu na %d minuta. Razlog: %s", Name(playerid), imeigraca, vrijeme, razlog);
	SendClientMessageToAll(COLOR_ADMWARN, offline_area);
	AdminLog(offline_area);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Taj igrac nije pronadjen u bazi podataka! Provjerite ime i pokusajte opet."); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:area(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	new imeigraca, vrijeme, razlog[16];
	if(sscanf(params, "dds[16]", imeigraca, vrijeme, razlog)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /area [id/ime igraca] [vrijeme u min] [razlog]");
	if(IsPlayerConnected(imeigraca) == 1){

		PlayerInfo[imeigraca][pArea] = 1;
		PlayerInfo[imeigraca][pAreaMin] = vrijeme-1;
		PlayerInfo[imeigraca][pAreaSec] = 59;
		SetPlayerInterior(imeigraca, 0);
		SetPlayerVirtualWorld(imeigraca, 1234);
		RemovePlayerFromVehicle(imeigraca);
		ResetPlayerWeapons(imeigraca);
		SetPlayerPos(imeigraca, -2290.6729, -1644.3998, 483.5132);

		new arean[128];
		format(arean, sizeof(arean), "SERVER: Admin %s je stavio igraca %s u areu na %d minuta. Razlog: %s", Name(playerid), Name(imeigraca), vrijeme, razlog);
		SendClientMessageToAll(COLOR_ADMWARN, arean);
		PlayerTextDrawShow(playerid, AreaJailTD0[playerid]);
		AdminLog(arean);
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	new imeigraca, skin;
	if(sscanf(params, "dd", imeigraca, skin)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /setskin [id/ime igraca] [id skina]");
	SetPlayerSkin(imeigraca, skin);

	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
	if(PlayerInfo[aon][pAdmin] >= 1 && PlayerInfo[aon][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je postavio skin igracu %s na id %d", Name(playerid), Name(imeigraca), skin);
	SendClientMessage(aon, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
ALTCOMMAND:dajarm->setarmour;
ALTCOMMAND:setarm->setarmour;
CMD:setarmour(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /setarmor [id/ime igraca]");

	SetPlayerArmour(strval(params), 100);
	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
	if(PlayerInfo[aon][pAdmin] >= 1 && PlayerInfo[aon][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je postavio armour igracu %s na 100", Name(playerid), Name(strval(params)));
	SendClientMessage(aon, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:aveh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(GetPVarInt(playerid, "IsAvehSpawned") == 0){
	new Float:x_av, Float:y_av, Float:z_av;
	new aveh[MAX_PLAYER_NAME];
	GetPlayerPos(playerid, x_av, y_av, z_av);
	aveh[playerid] = CreateVehicle(579, x_av, y_av, z_av, 90, 0, 0, 30);
	PutPlayerInVehicle(playerid, aveh[playerid], 0);
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Stvorili ste admin vozilo!");
	}
	else {
	SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Vec imate admin vozilo!");
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:a(playerid, params[]) //Za chat sa adminima
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
		for(new aon = 0; aon < MAX_PLAYERS; aon++)
		{
			new achat[150];
			format(achat, sizeof(achat), "xx Admin %s: %s xx", Name(playerid), params);
			if(PlayerInfo[aon][pAdmin] >= 1 && PlayerInfo[aon][pDuty] == 1){
			SendClientMessage(aon, 0xEF7250FF, achat);
			}
			AdminChat(achat);
		}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
ALTCOMMAND:sethealth->heal;
CMD:heal(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /heal [id/ime igraca]");

	SetPlayerHealth(strval(params), 100);
	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
		if(PlayerInfo[aon][pAdmin] >= 1 && PlayerInfo[aon][pDuty] == 1){
		new admwarn[128];
		format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je postavio health igracu %s na 100", Name(playerid), Name(strval(params)));
		SendClientMessage(aon, COLOR_ADMWARN, admwarn);
		AdminLog(admwarn);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
ALTCOMMAND:lideri->leaders;
CMD:leaders(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Trenutno lideri online:");
	for(new lon = 0; lon < MAX_PLAYERS; lon++)
	{
	if(PlayerInfo[lon][pRank] == 6){
		new imeOrge[20];
		if(PlayerInfo[playerid][pOrg] == 1) { imeOrge = "Carson Army"; 						 }
		if(PlayerInfo[playerid][pOrg] == 2) {imeOrge = "Sheriff Department"; 	     }
		if(PlayerInfo[playerid][pOrg] == 3) {imeOrge = "Carson Mafia"; 				     }
		if(PlayerInfo[playerid][pOrg] == 4) {imeOrge = "The Vinci Family"; 		     }

		new lider[48];
		format(lider, sizeof(lider), "(%s) - %s", imeOrge, Name(lon));
		SendClientMessage(playerid, COLOR_WHITE, lider);
	}
	}
	return 1;
}
ALTCOMMAND:admini->admins;
CMD:admins(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Trenutno admini online:");
	for(new aon = 0; aon < MAX_PLAYERS; aon++)
	{
	if(PlayerInfo[aon][pAdmin] > 1){
	if(PlayerInfo[aon][pDuty] == 1){
	new na_duznosti[32];
	format(na_duznosti, sizeof(na_duznosti), "%s (%d) - "STRING_GREEN"●", Name(aon), PlayerInfo[aon][pAdmin]);
	SendClientMessage(playerid, COLOR_WHITE, na_duznosti);
	}
	else {
	new na_duznosti[32];
	format(na_duznosti, sizeof(na_duznosti), "%s (%d) - "STRING_RED"●", Name(aon), PlayerInfo[aon][pAdmin]);
	SendClientMessage(playerid, COLOR_WHITE, na_duznosti);
	}
	}
	}
	return 1;
}
CMD:gethere(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /gethere [id/ime igraca]");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(strval(params), x, y, z);

	for(new aw_gethere = 0; aw_gethere < MAX_PLAYERS; aw_gethere++)
	{
	if(PlayerInfo[aw_gethere][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je teleportirao %s do sebe", Name(playerid), Name(strval(params)));
	SendClientMessage(aw_gethere, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:goto(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /goto [id/ime igraca]");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(strval(params), x, y, z);
	SetPlayerPos(playerid, x, y, z);

	for(new aw_teleport = 0; aw_teleport < MAX_PLAYERS; aw_teleport++)
	{
	if(PlayerInfo[aw_teleport][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s se teleportirao do %s", Name(playerid), Name(strval(params)));
	SendClientMessage(aw_teleport, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:kill(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /kill [id/ime igraca]");

	SetPlayerHealth(strval(params), 0.0);

	for(new aw_kill = 0; aw_kill < MAX_PLAYERS; aw_kill++)
	{
	if(PlayerInfo[aw_kill][pDuty] == 1){
	new admwarn[128];
	format(admwarn, sizeof(admwarn), "ADMIN WARN: Admin %s je ubio %s pomocu /kill", Name(playerid), Name(strval(params)));
	SendClientMessage(aw_kill, COLOR_ADMWARN, admwarn);
	AdminLog(admwarn);

	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:aduty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1){
	if(PlayerInfo[playerid][pDuty] == 0) {
	PlayerInfo[playerid][pDuty] = 1;
	SendClientMessage(playerid, COLOR_ADMWARN, "ADMIN WARN: Sada ste admin na duznosti!");
	new admin_duznost[128];
	format(admin_duznost, sizeof(admin_duznost), ""STRING_GRAY"(( Admin "STRING_WHITE"%s"STRING_GRAY" je sada na duznosti. Ukucajte "STRING_WHITE"/report"STRING_GRAY" za pitanja ))", Name(playerid));
	SendClientMessageToAll(-1, admin_duznost);
	}
	else {
	PlayerInfo[playerid][pDuty] = 0;
	SendClientMessage(playerid, COLOR_ADMWARN, "ADMIN WARN: Sada vise niste na duznosti!");
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti admin da koristite ovu komandu!");}
	return 1;
}
CMD:ateleport(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1){
	ShowPlayerDialog(playerid, DIALOG_ATELEPORT, DIALOG_STYLE_LIST, "ADMIN TELEPORT | ODABERITE LOKACIJU", "Organizacije\nPoslovi\nSpawn\nLas Barrancas", "Odaberi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti admin na duznosti da koristite ovu komandu!");}
	return 1;
}
CMD:drvosjeca(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 7){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, -525.9680,-95.6334,62.7603)){
	ShowPlayerDialog(playerid, DIALOG_DRVOSJECA, DIALOG_STYLE_LIST, "DRVOSJECA - Odabir posla", "Sjeca drva\nTransport drva", "Odaberi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste u blizini odabira rute za drvosjecu!"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti zaposljeni kao drvosjeca da koristite ovu komandu!");}
	return 1;
}
CMD:blackmarket(playerid,params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, -657.9172,1447.0024,13.6172)){
	ShowPlayerDialog(playerid, DIALOG_BLACKMARKET, DIALOG_STYLE_LIST, "-[ CRNO TRZISTE ]-", "Kupi sjeme\nKupi drogu\nProdaj drogu\nObradi drogu", "Odaberi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste u blizini crnog trzista."); }
	return 1;
}
CMD:utovari(playerid,params[])
{
	if(GetPVarInt(playerid, "ima_mlijeko") == 1){
	new Float:x_ut, Float:y_ut, Float:z_ut;
	new Float:x1, Float:y1, Float:z1;
	new Float:x2, Float:y2, Float:z2;
	new Float:x3, Float:y3, Float:z3;
	new Float:x4, Float:y4, Float:z4;
	GetVehiclePos(farm[10], x_ut, y_ut, z_ut);
	GetVehiclePos(farm[11], x1, y1, z1);
	GetVehiclePos(farm[12], x2, y2, z2);
	GetVehiclePos(farm[13], x3, y3, z3);
	GetVehiclePos(farm[14], x4, y4, z4);
	if(IsPlayerInRangeOfPoint(playerid, 5.0, x_ut, y_ut, z_ut) || IsPlayerInRangeOfPoint(playerid, 5.0, x1, y1, z1) ||IsPlayerInRangeOfPoint(playerid, 5.0, x2, y2, z2) || IsPlayerInRangeOfPoint(playerid, 5.0, x3, y3, z3) || IsPlayerInRangeOfPoint(playerid, 5.0, x4, y4, z4)){
	SetPVarInt(playerid, "ima_mlijeko", 0);
	RemovePlayerAttachedObject(playerid, 0);
	SetPVarInt(playerid, "utovario_mlijeko", 1);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "Trebate biti u blizini kamiona za raznos mlijeka."); }
	}
	return 1;
}
CMD:muznja(playerid,params[])
{
	if(PlayerInfo[playerid][pJob] == 5){
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 315.36346, 1172.10803, 9.65489) && zkrava1 == 0){
	zkrava1 = 1;
	SetTimerEx("muznja", 10000, false, "i", playerid);
	TogglePlayerControllable(playerid, 0);
	GameTextForPlayer(playerid, "Muznja krave...", 10000, 4);
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Netko vec muze tu kravu!"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti zaposleni kao "STRING_WHITE"farmer"STRING_ADMWARN" da koristite tu komandu"); }
	return 1;
}
CMD:spoji(playerid,params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 354.9556, 1159.5619, 7.3228) || IsPlayerInRangeOfPoint(playerid, 3.0, 354.9737, 1165.9690, 7.3228) || IsPlayerInRangeOfPoint(playerid, 3.0, 355.1246, 1172.0917, 7.3228)){
	if(GetPlayerVehicleID(playerid) == farm[4] || GetPlayerVehicleID(playerid) == farm[5] || GetPlayerVehicleID(playerid) == farm[6]){
	if(GetPVarInt(playerid, "zapoceo") == 1){
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 354.9556, 1159.5619, 7.3228)) { AttachTrailerToVehicle(farm[7], GetPlayerVehicleID(playerid)); }
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 354.9737, 1165.9690, 7.3228)) { AttachTrailerToVehicle(farm[8], GetPlayerVehicleID(playerid)); }
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 355.1246, 1172.0917, 7.3228)) { AttachTrailerToVehicle(farm[9], GetPlayerVehicleID(playerid)); }
	SendClientMessage(playerid, COLOR_YELLOW, "Krenite sijati zito na oznacenom mjestu.");
	SetPlayerCheckpoint(playerid, 263.18665, 1152.49268, 10, 2.0);
	zauzeto = 1;
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate zapoceti rutu da spojite sijacicu!"); }
	}
	else {SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u traktoru da spojite sijacicu!"); }
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u blizini sijacice da ju spojite!"); }
	return 1;
}
CMD:work(playerid,params[])
{
	if(PlayerInfo[playerid][pJob] != 0){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 311.7521,1129.3335,9.4497) && PlayerInfo[playerid][pJob] == 5){ //Farmer
	ShowPlayerDialog(playerid, DIALOG_FARM, DIALOG_STYLE_LIST, "Odaberite rutu", "Sijanje zita #1\nSijanje zita #2\nSijanje zita #3\nZetva #1\nZetva #2\nZetva #3", "Kreni", "Odustani");
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti zaposleni da koristite tu komandu!");}
	return 1;
}
CMD:takejob(playerid,params[])
{
	if(PlayerInfo[playerid][pJob] == 0){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, -636.5583,1446.6155,13.9965)){ // Uzgajivac droge
	PlayerInfo[playerid][pJob] = 6;
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Uspjesno ste se zaposlili kao Uzgajivac droge!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 295.9053,1129.8921,9.4619)){ // Farmer
	PlayerInfo[playerid][pJob] = 5;
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Uspjesno ste se zaposlili kao Farmer!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.0, -537.2394,-97.8130,63.2969)){
	PlayerInfo[playerid][pJob] = 7;
	SendClientMessage(playerid, COLOR_YELLOW, "INFO: Uspjesno ste se zaposlili kao Drvosjeca!");
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Vec ste zaposleni.");}
	return 1;
}
CMD:o(playerid,params[])
{
	if(PlayerInfo[playerid][pOrg] != 0){
	if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /o [tekst]");
	for(new clan = 0; clan < MAX_PLAYERS; clan++)
	{
	new poruka[256];
	format(poruka,sizeof(poruka),"** R%i %s: %s **",PlayerInfo[playerid][pRank],Name(playerid),params);
	SendClientMessage(clan, COLOR_ORGCHAT, poruka);
	}
	}
	else {SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u organizaciji da koristite tu komandu!"); }
	return 1;
}
CMD:f(playerid,params[])
{
	if(PlayerInfo[playerid][pRank] == 6){
	new lchat[256];
	new orga[32];
	if(PlayerInfo[playerid][pOrg] == 1){ orga = "Carson Army"; }
	if(PlayerInfo[playerid][pOrg] == 2){ orga = "Sherrif Department"; }
	if(PlayerInfo[playerid][pOrg] == 3){ orga = "Street Tigers"; }
	if(PlayerInfo[playerid][pOrg] == 4){ orga = "Vagos Gang"; }
	format(lchat,sizeof(lchat),"** %s | %s: %s **", orga,Name(playerid),params);
	for(new lider = 0; lider < MAX_PLAYERS; lider++)
	{
	if(PlayerInfo[lider][pRank] == 6){
	SendClientMessage(playerid, COLOR_LCHAT, lchat);
	}
	}
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti lider da koristite ovu komandu!"); }
	return 1;
}
CMD:leader(playerid,params[])
{
	if(PlayerInfo[playerid][pRank] == 6){
	if(isnull(params)){
	SendClientMessage(playerid,COLOR_ADMWARN,"[VR:RPG]: Koristenje: "STRING_GRAY"/"STRING_ADMWARN"("STRING_GRAY"l"STRING_ADMWARN")"STRING_GRAY"eader [opcija]");
	SendClientMessage(playerid,COLOR_ADMWARN,"OPCIJE:"STRING_GRAY" invite | kick | rank | derank");
	}
	if(!strcmp(params,"invite",true)){
	ShowPlayerDialog(playerid,DIALOG_INVITE, DIALOG_STYLE_INPUT, "Invite","Unesite ID igraca kojeg zelite pozvati u vasu organizaciju.", "Invite", "Odustani");
	}
	if(!strcmp(params,"kick",true)){
	ShowPlayerDialog(playerid, DIALOG_ORG_KICK, DIALOG_STYLE_INPUT, "Kick clana", "Unesite ID igraca kojeg zelite izbaciti iz organizacije", "Kick", "Odustani");
	}
	if(!strcmp(params,"rank",true)){
	ShowPlayerDialog(playerid, DIALOG_ORG_RANK, DIALOG_STYLE_INPUT, "Rankup clana", "Unesite ID igraca kojeg zelite unaprijediti", "Rankup", "Odustani");
	}
	if(!strcmp(params,"derank",true)){
	ShowPlayerDialog(playerid, DIALOG_ORG_DERANK, DIALOG_STYLE_INPUT, "Derank clana", "Unesite ID igraca kojem zelite sniziti rank", "Derank", "Odustani");
	}
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti lider da koristite ovu komandu!"); }
	return 1;
}
CMD:veh(playerid,params[])
{
	if(PlayerInfo[playerid][Car1ID] != 0){
	ShowPlayerDialog(playerid, DIALOG_VEHICLE, DIALOG_STYLE_LIST, "Vozilo #1", "Otkljucaj/Zakljucaj\nLociraj\nParkiraj\nPromijeni boju\nProdaj", "Odaberi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate imati auto da koristite ovu komandu"); }
	return 1;
}
CMD:stvoriauto(playerid,params[])
{
	new stringer[128];
	format(stringer, sizeof(stringer), "Vehicle/%i.ini", 1);
	new INI:vehicle = INI_Open(stringer);
	INI_SetTag(vehicle,"data");
	INI_WriteInt(vehicle,"ID",1);
	INI_WriteInt(vehicle,"Cijena",0);
	INI_WriteString(vehicle,"Vlasnik","Nitko");
	INI_Close(vehicle);
	return 1;
}
CMD:kupiauto(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] >= 3){
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 356.3181,152.1401,1025.7891)){
	ShowPlayerDialog(playerid, DIALOG_AUTOSALON, DIALOG_STYLE_TABLIST, "Vozila", "Bravura\t$15,000\nBuffalo\t$400,000\nVoodoo\t$35,000\nCheetah\t$500,000\nBobcat\t$55,000\nGlendale\t$10,000\nSabre\t$100,000\nRancher\t$125,000\nMesa\t$135,000\nAdmiral\t$40,000\nBuccaneer\t$30,000\nClover\t$80,000\nSadler\t$20,000\nTampa\t$10,000\nFlash\t$90,000\nHuntley\t $300,000", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Niste u auto salonu!"); }
}
else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti level "STRING_WHITE"3+"STRING_ADMWARN" da kupite vozilo."); }
return 1;
}
CMD:pozovi(playerid, params[]) //NIJE GOTOVO !!
{

	return 1;
}
CMD:nightclub(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 4.0, 499.9700,-20.5780,1000.6797)){
	ShowPlayerDialog(playerid, DIALOG_NIGHTCLUB, DIALOG_STYLE_LIST, "Nocni klub", "$20 - Martini\n$35 - Mojito\n$40 - Margarita\n$50 - Sex On The Beach\n$500 - Privatna soba", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u nocnom klubu da koristite ovu komandu."); }
	return 1;
}
CMD:buyweapon(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 312.1584,-165.8447,999.6010)){
	ShowPlayerDialog(playerid, DIALOG_WEAPON, DIALOG_STYLE_LIST, "Kupite oruzje", "$250 - Pistolj\n$300 - Deagle\n$900 - Micro Uzi\n$3000 - AK47\n$3000 - M4\n$10000 - Sniper", "Kupi", "Odustani"); //NIJE DOVRSENO
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti u oruzarnici da kupite oruzje"); }
	return 1;
}
CMD:business(playerid, params[])
{
	if(PlayerInfo[playerid][BiznisID] == 0) return  SCM(playerid,COLOR_ADMWARN,"ERROR: "STRING_GRAY"Morate imati biznis(firmu) da koristite ovu komandu.");
	else{
	if(GetPlayerVirtualWorld(playerid) == PlayerInfo[playerid][BiznisID]+100 && GetPlayerVirtualWorld(playerid) != 0){
	ShowPlayerDialog(playerid, DIALOG_BIZNIS1, DIALOG_STYLE_LIST, "Business Panel", "Blagajna\nUzmi novac\nProdaj", "Odaberi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR:"STRING_GRAY"Morate biti u svom biznisu(firmi) da koristite ovu komandu."); }
	}
	return 1;
}
CMD:banka(playerid,params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2316.6213,-7.5301,26.7422)){
	ShowPlayerDialog(playerid, DIALOG_BANKA, DIALOG_STYLE_LIST, "Odaberite", "Stanje na racunu\nPodigni novac\nOstavi novac\nTransfer novca\nPodigni placu", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u banci da koristite ovu komandu!"); }
	return 1;
}
CMD:restoran(playerid,params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 681.5786,-451.4769,-25.6172)){
	ShowPlayerDialog(playerid, DIALOG_RESTORAN, DIALOG_STYLE_LIST, "Odaberite hranu", "$15 - Prsut i sir\n$30 - Juha\n$35 - Cevapi\n$45 - Krompir ispod saca\n$55 - Riba i Skampi\n$100 - Biftek & Salata", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u restoranu da koristite ovu komandu!"); }
	return 1;
}
CMD:bacibocu(playerid, params[])
{
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_WINE) { SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE); }
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK) { SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE); }
	return 1;
}
CMD:drink(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 495.6192,-75.8747,998.7578)){
	ShowPlayerDialog(playerid, DIALOG_DRINK, DIALOG_STYLE_LIST, "Odaberite pice", "$15 - Voda\n$25 - Coca Cola\n$50 - Votka\n$65 - Red Label\n$90 - Viski", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u baru da koristite ovu komandu!"); }
	return 1;
}
CMD:fastfood(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 377.5997,-68.2366,1001.5151)){
	ShowPlayerDialog(playerid, DIALOG_FASTFOOD, DIALOG_STYLE_LIST, "Odaberite hranu", "$15 - Pomfrit\n$30 - Cheeseburger\n$35 - Hamburger\n$45 - Hamburger & Pomfrit\n$55 - Pecena Piletina\n$100 - Obiteljski Fastfood", "Kupi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate biti u fast-foodu da koristite ovu komandu!"); }
	return 1;
}
CMD:oglas(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1491.1897, 1307.3757, 1093.2891)){
	ShowPlayerDialog(playerid,DIALOG_OGLAS, DIALOG_STYLE_INPUT, "Posaljite oglas","Unesite tekst vaseg oglasa.", "Objavi", "Odustani");
	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "Trebate biti u Marketing agenciji da objavite oglas!"); }
	return 1;
}
ALTCOMMAND:kupitvrtku->buybusiness;
ALTCOMMAND:kupifirmu->buybusiness;
ALTCOMMAND:buyb->buybusiness;
CMD:buybusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] >= 3){
	if(PlayerInfo[playerid][BiznisID] == 0 ){
	for(new b = 0; b < MAX_BUSINESS; b++){
	if(IsPlayerInRangeOfPoint(playerid, 3.0, BiznisInfo[b][bUlazX], BiznisInfo[b][bUlazY], BiznisInfo[b][bUlazZ])){
	if(GetPlayerCash(playerid) >= BiznisInfo[b][bID]){

	PlayerInfo[playerid][BiznisID] = BiznisInfo[b][bID];
	BiznisInfo[b][bProdano] = 1;

	BiznisInfo[b][bVlasnik] = Name(playerid); // Postavlja vlasnika
	GivePlayerCash(playerid, -BiznisInfo[b][bCijena]);
	Delete3DTextLabel(Text3D:TextNeprodano[b]);
	DestroyPickup(PickupBiznisNeprodano[b]);


	new biznisKupljeno[190];
	new imeBiznisa[64];
	if (BiznisInfo[b][bTip] == 0) { imeBiznisa = "Prodavnica"; }
	if (BiznisInfo[b][bTip] == 1) { imeBiznisa = "Marketing Agencija"; }
	if (BiznisInfo[b][bTip] == 2) { imeBiznisa = "Fast Food"; }
	if (BiznisInfo[b][bTip] == 3) { imeBiznisa = "Bar"; }
	if (BiznisInfo[b][bTip] == 4) { imeBiznisa = "Restoran"; }

	format(biznisKupljeno,sizeof(biznisKupljeno), ""STRING_YELLOW"--------------\n"STRING_WHITE"%s\n"STRING_YELLOW"Vlasnik: "STRING_WHITE"%s"STRING_YELLOW"\nDa udjete\npritisnite "STRING_WHITE"'F'"STRING_YELLOW"\n--------------",imeBiznisa, BiznisInfo[b][bVlasnik]);
	TextProdano[b] = Create3DTextLabel(biznisKupljeno,-1,BiznisInfo[b][bUlazX],BiznisInfo[b][bUlazY],BiznisInfo[b][bUlazZ],40.0,0,1);
	PickupBiznisProdano[b] = CreatePickup(1239,1,BiznisInfo[b][bUlazX],BiznisInfo[b][bUlazY],BiznisInfo[b][bUlazZ],-1);
	SendClientMessage(playerid, COLOR_ADMWARN, "[VR:RPG]: "STRING_GRAY"Uspjesno ste kupili biznis(tvrtku)! Kucajte "STRING_ADMWARN"/(b)usiness"STRING_GRAY" da vidite komande.");
	SpremiBiznise(PlayerInfo[playerid][BiznisID]);
	}
	}
	}
	}
  }
	return 1;
}
ALTCOMMAND:kuca->house;
ALTCOMMAND:h->house;
CMD:house(playerid, params[])
{
	if(GetPlayerVirtualWorld(playerid) == PlayerInfo[playerid][KucaID] && GetPlayerVirtualWorld(playerid) != 0){
	if(isnull(params)){
	SendClientMessage(playerid,COLOR_ADMWARN,"[VR:RPG]: Koristenje: "STRING_GRAY"/"STRING_ADMWARN"("STRING_GRAY"h"STRING_ADMWARN")"STRING_GRAY"ouse [opcija]");
	SendClientMessage(playerid,COLOR_ADMWARN,"OPCIJE:"STRING_GRAY" lock | unlock | withdraw | deposit | takeweapon | leaveweapon | sell");
	}
	if(!strcmp(params,"sell",true)){
	ShowPlayerDialog(playerid,DIALOG_SELL1, DIALOG_STYLE_INPUT, "Prodajte kucu","Unesite ID igraca kojem zelite prodati kucu.", "Dalje", "Odustani");
	}
	if(!strcmp(params,"lock",true)){
	KucaInfo[GetPlayerVirtualWorld(playerid)][kLocked] = 1;
	SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_GRAY" Zakljucali ste svoju kucu.");
	}
	if(!strcmp(params,"unlock",true)){
	KucaInfo[GetPlayerVirtualWorld(playerid)][kLocked] = 0;
	SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_GRAY" Otkljucali ste svoju kucu.");
	}
	if(!strcmp(params,"withdraw",true)){
	new withdraw[74];
	format(withdraw,sizeof(withdraw), "Upisite koliko novca zelite uzeti. Trenutno stanje: "STRING_GREEN"$%i", KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]);
	ShowPlayerDialog(playerid,DIALOG_HWITHDRAW, DIALOG_STYLE_INPUT, "Uzmite novac",withdraw, "Uzmi", "Odustani");
	}
	if(!strcmp(params,"deposit",true)){
	new deposit[74];
	format(deposit,sizeof(deposit), "Upisite koliko novca zelite ostaviti. Trenutno stanje: "STRING_GREEN"$%i", KucaInfo[GetPlayerVirtualWorld(playerid)][kMoney]);
	ShowPlayerDialog(playerid,DIALOG_HDEPOSIT, DIALOG_STYLE_INPUT, "Ostavite novac",deposit, "Uzmi", "Odustani");
	}
	if(!strcmp(params,"takeweapon",true)){ //Uzima oruzje iz kuce
	if(KucaInfo[GetPlayerVirtualWorld(playerid)][kOruzje] != 0){
    GivePlayerWeapon(playerid,KucaInfo[GetPlayerVirtualWorld(playerid)][kOruzje], KucaInfo[GetPlayerVirtualWorld(playerid)][kAmmo]);
   	SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_GRAY" Uzeli ste oruzje iz kuce.");
   	KucaInfo[GetPlayerVirtualWorld(playerid)][kOruzje] = 0;
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Nemate oruzje u kuci."); }
	}
	if(!strcmp(params,"leaveweapon",true)){ //Ostavlja oruzje u kuci (Samo jedno oruzje moze biti)
	if(KucaInfo[GetPlayerVirtualWorld(playerid)][kOruzje] == 0){
	KucaInfo[GetPlayerVirtualWorld(playerid)][kOruzje] = GetPlayerWeapon(playerid);
	KucaInfo[GetPlayerVirtualWorld(playerid)][kAmmo] = GetPlayerAmmo(playerid);
	SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
   	SendClientMessage(playerid,COLOR_ADMWARN,"INFO:"STRING_GRAY" Ostavili ste oruzje u kucu.");
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Vec imate oruzje u kuci."); }
	}
	if(GetPlayerVirtualWorld(playerid) != PlayerInfo[playerid][KucaID] || GetPlayerVirtualWorld(playerid) == 0){ SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Niste u svojoj kuci.");}
 	}
	return 1;
}
ALTCOMMAND:izadji->exit;
CMD:exit(playerid, params[]) //Izlazi iz interijera
{
		if(GetPlayerInterior(playerid) != 0 || IsPlayerInRangeOfPoint(playerid, 100.0, 2315.952880,-1.618174,26.742187) || IsPlayerInRangeOfPoint(playerid, 100.0, 663.836242,-575.605407,16.343263)){
		SetPlayerInterior(playerid,0);
    SetPlayerPos(playerid, GetPVarFloat(playerid,"xpos"), GetPVarFloat(playerid,"ypos"), GetPVarFloat(playerid,"zpos"));
    SetPlayerVirtualWorld(playerid,0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    }
	return 1;
}
CMD:kupikucu(playerid, params[]) //Komanda za kupnju kuce
{
	if(PlayerInfo[playerid][pLevel] >= 3){ //Provjerava level igraca
	if(PlayerInfo[playerid][KucaID] == 0){
    for(new k = 1; k < MAX_HOUSE; k++){
	if(IsPlayerInRangeOfPoint(playerid,3.0,KucaInfo[k][kUlazX],KucaInfo[k][kUlazY],KucaInfo[k][kUlazZ])){
	if(GetPlayerMoney(playerid) >= KucaInfo[k][kCijena]){

	    PlayerInfo[playerid][KucaID] = KucaInfo[k][kID];
	    KucaInfo[k][kProdano] = 1;
//______________________________________________________________________________
	    KucaInfo[k][kVlasnik] = Name(playerid); //Postavlja ime vlasnika kuce
//______________________________________________________________________________
	    GivePlayerMoney(playerid, -KucaInfo[k][kCijena]); //Oduzima novac
//______________________________________________________________________________
	  new prodana2[128];
		format(prodana2,sizeof(prodana2), ""STRING_ADMWARN"-----------\nVlasnik kuce: "STRING_WHITE"%s\n"STRING_ADMWARN"Da udjete u kucu\npritisnite "STRING_WHITE"'F'"STRING_ADMWARN"\n-----------", KucaInfo[k][kVlasnik]);
		KucaLabelDa[k] = Create3DTextLabel(prodana2,-1,KucaInfo[k][kUlazX],KucaInfo[k][kUlazY],KucaInfo[k][kUlazZ],35.0,0,1);
//______________________________________________________________________________
        Delete3DTextLabel(Text3D:KucaLabelNe[k]);
		DestroyPickup(KucaPickupNe[k]); //Unistava zelenu ikonu kuce
	    CreatePickup(1272,1,KucaInfo[k][kUlazX],KucaInfo[k][kUlazY],KucaInfo[k][kUlazZ],-1); //Dodaje plavu ikonukuce (oznacava da je kupljena)
	    SendClientMessage(playerid,COLOR_ADMWARN,"[VR-RPG]"STRING_GRAY"Uspjesno ste kupili kucu! Da vidite komande kucajte "STRING_ADMWARN"/house "STRING_GRAY"("STRING_ADMWARN"/kuca"STRING_GRAY")");
		SpremiKuce(k);
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR:"STRING_WHITE" Nemate dovoljno novca kod sebe da kupite kucu!"); }
	}
	}
		}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR:"STRING_WHITE" Vec imate kucu!"); }
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR:"STRING_WHITE" Trebate biti level 3+ da kupite kucu!"); }
	return 1;
}
CMD:resetbiznisa(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337 && PlayerInfo[playerid][pDuty] == 1){
	for(new ipy = 0; ipy < MAX_BUSINESS; ipy++){
	new bFile[80];
	format(bFile,sizeof(bFile),BiznisPath, ipy);
	if(fexist(bFile)){
	    INI_ParseFile(bFile,"UcitajBiznisInfo", .bExtra = true, .extra = ipy);
//______________________________________________________________________________
	if (BiznisInfo[ipy][bProdano] == 0) { PickupBiznisNeprodano[ipy] = CreatePickup(1273,1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],-1); }
	if (BiznisInfo[ipy][bProdano] == 1) { PickupBiznisProdano[ipy] = CreatePickup(1239,1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],-1); }

	new biznisNEProdano[128];

	new biznisKupljeno[128];
	new imeBiznisa[64];
	if (BiznisInfo[ipy][bTip] == 0) { imeBiznisa = "Prodavnica"; }
	if (BiznisInfo[ipy][bTip] == 1) { imeBiznisa = "Marketing Agencija"; }
	if (BiznisInfo[ipy][bTip] == 2) { imeBiznisa = "Fast Food"; }
	if (BiznisInfo[ipy][bTip] == 3) { imeBiznisa = "Bar"; }
	if (BiznisInfo[ipy][bTip] == 4) { imeBiznisa = "Restoran"; }
	if (BiznisInfo[ipy][bTip] == 5) { imeBiznisa = "Banka"; }
	if (BiznisInfo[ipy][bTip] == 6) { imeBiznisa = "Oruzarnica"; }
	if (BiznisInfo[ipy][bTip] == 7) { imeBiznisa = "Nocni Klub"; }
	if (BiznisInfo[ipy][bTip] == 8) { imeBiznisa = "Sex Shop"; }
	if (BiznisInfo[ipy][bTip] == 9) { imeBiznisa = "Skin Shop"; }


	format(biznisNEProdano,sizeof(biznisNEProdano), ""STRING_LJUBIC"--------------\n%s na prodaju\nCijena: "STRING_WHITE"$%i\n"STRING_LJUBIC"Kucajte "STRING_WHITE"/kupitvrtku"STRING_LJUBIC" da kupite\n--------------", imeBiznisa, BiznisInfo[ipy][bCijena]);
	if(BiznisInfo[ipy][bProdano] == 0) { TextNeprodano[ipy] = Create3DTextLabel(biznisNEProdano,-1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],40.0,0,1); }

	format(biznisKupljeno,sizeof(biznisKupljeno), ""STRING_YELLOW"--------------\n"STRING_WHITE"%i\n"STRING_YELLOW"Vlasnik:"STRING_WHITE"%s"STRING_YELLOW"\nDa udjete u tvrtku\npritisnite "STRING_WHITE"'F'"STRING_YELLOW"\n--------------",imeBiznisa, BiznisInfo[ipy][bVlasnik]);
	if(BiznisInfo[ipy][bProdano] == 1) { TextProdano[ipy] = Create3DTextLabel(biznisKupljeno,-1,BiznisInfo[ipy][bUlazX],BiznisInfo[ipy][bUlazY],BiznisInfo[ipy][bUlazZ],40.0,0,1); }
//______________________________________________________________________________
	}
	}
	}
	return 1;
}
CMD:resetkuca(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337 && PlayerInfo[playerid][pDuty] == 1)
	{
    for(new ipx = 0; ipx < MAX_HOUSE; ipx++)
{
	new cFile[80];
	format(cFile,sizeof(cFile),KucaPath, ipx);
	if(fexist(cFile))
	{
		INI_ParseFile(cFile, "UcitajKucaInfo", .bExtra = true, .extra = ipx);
//______________________________________________________________________________
	if (KucaInfo[ipx][kProdano] == 0) { KucaPickupNe[ipx] = CreatePickup(1272,1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],-1); }
	if (KucaInfo[ipx][kProdano] == 1) { KucaPickupDa[ipx] = CreatePickup(19522,1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],-1); }

	new neprodana[128];
	format(neprodana,sizeof(neprodana), ""STRING_GREEN"-----------\nKuca je na prodaju\nCijena: "STRING_WHITE"$%i\n"STRING_GREEN"Kucajte "STRING_WHITE"/kupikucu"STRING_GREEN" da kupite\n-----------",KucaInfo[ipx][kCijena]);
	if (KucaInfo[ipx][kProdano] == 0) { nekupljena = Create3DTextLabel(neprodana,-1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],35.0,0,1); }

	new prodana[128];
	format(prodana,sizeof(prodana), ""STRING_ADMWARN"-----------\nVlasnik kuce: "STRING_WHITE"%s\n"STRING_ADMWARN"Da udjete u kucu\npritisnite "STRING_WHITE"'F'"STRING_ADMWARN"\n-----------", KucaInfo[ipx][kVlasnik]);
	if (KucaInfo[ipx][kProdano] == 1) { kupljena = Create3DTextLabel(prodana,-1,KucaInfo[ipx][kUlazX],KucaInfo[ipx][kUlazY],KucaInfo[ipx][kUlazZ],35.0,0,0); }
	}
//______________________________________________________________________________
}
}
	else { SendClientMessage(playerid,COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:cc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && PlayerInfo[playerid][pDuty] == 1)
	{
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
	    SendClientMessageToAll(-1, " ");
		SendClientMessageToAll(COLOR_ADMWARN, "Chat je ociscen od strane admina.");
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN, "ERROR: Trebate biti admin na duznosti da koristite ovu komandu"); }
	return 1;
}
CMD:stats(playerid, params[])
{
	if(GetPVarInt(playerid,"stats") == 0)
	{
	    SetPVarInt(playerid,"stats", 1);
		TextDrawShowForPlayer(playerid, stats0[playerid]);
		TextDrawShowForPlayer(playerid, stats1[playerid]);
		TextDrawShowForPlayer(playerid, stats2[playerid]);
//------------------------------------------------------------------------------
	    new newtext[41], name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	    format(newtext, sizeof(newtext), "%s", name);
	    TextDrawSetString(stats3[playerid], newtext);
		TextDrawShowForPlayer(playerid, stats3[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats4[playerid]);
//------------------------------------------------------------------------------
  		new level[128];
	    format(level, sizeof(level), "Level: %i", PlayerInfo[playerid][pLevel]);
	    TextDrawSetString(stats5[playerid], level);
		TextDrawShowForPlayer(playerid, stats5[playerid]);
//------------------------------------------------------------------------------
  		new respekt[128];
  		if (PlayerInfo[playerid][pLevel] >= 5 && PlayerInfo[playerid][pLevel] <= 20)
  		{
	    format(respekt, sizeof(respekt), "Respekt: %i/16", PlayerInfo[playerid][pRespekt]);
	    }
	    else if (PlayerInfo[playerid][pLevel] > 20)
	    {
     	format(respekt, sizeof(respekt), "Respekt: %i/36", PlayerInfo[playerid][pRespekt]);
	    }
	    else if (PlayerInfo[playerid][pLevel] < 5)
	    {
     	format(respekt, sizeof(respekt), "Respekt: %i/10", PlayerInfo[playerid][pRespekt]);
	    }
	    TextDrawSetString(stats6[playerid], respekt);
		TextDrawShowForPlayer(playerid, stats6[playerid]);
//------------------------------------------------------------------------------
		new DoRespekta[120];
		format(DoRespekta, sizeof(DoRespekta), "Do respekta: %i/60", PlayerInfo[playerid][pDoRespekta]);
		TextDrawSetString(stats7[playerid], DoRespekta);
		TextDrawShowForPlayer(playerid, stats7[playerid]);
//------------------------------------------------------------------------------
		new novac[32];
		format(novac, sizeof(novac), "Novac: $%i", GetPlayerMoney(playerid));
		TextDrawSetString(stats8[playerid], novac);
		TextDrawShowForPlayer(playerid, stats8[playerid]);
//------------------------------------------------------------------------------
		new BankaNovac[32];
		format(BankaNovac, sizeof(BankaNovac), "Banka: $%i", PlayerInfo[playerid][pBanka]);
		TextDrawSetString(stats9[playerid], BankaNovac);
		TextDrawShowForPlayer(playerid, stats9[playerid]);
//------------------------------------------------------------------------------
		new oruzje[32];
		format(oruzje, sizeof(oruzje), "Dozv. oruzje: %ih", PlayerInfo[playerid][pOruzje]);
		TextDrawSetString(stats10[playerid], oruzje);
		TextDrawShowForPlayer(playerid, stats10[playerid]);
//------------------------------------------------------------------------------
		new letenje[32];
		format(letenje, sizeof(letenje), "Dozv. letenje: %ih", PlayerInfo[playerid][pLetenje]);
		TextDrawSetString(stats11[playerid], letenje);
		TextDrawShowForPlayer(playerid, stats11[playerid]);
//------------------------------------------------------------------------------
		new kazne[32];
		format(kazne, sizeof(kazne), "Kazne: %i", PlayerInfo[playerid][pKazne]);
		TextDrawSetString(stats12[playerid], kazne);
		TextDrawShowForPlayer(playerid, stats12[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats13[playerid]);
//------------------------------------------------------------------------------
		if(PlayerInfo[playerid][pOrg] == 1) {TextDrawSetString(stats14[playerid], "Org: Carson Army");}
		if(PlayerInfo[playerid][pOrg] == 2) {TextDrawSetString(stats14[playerid], "Org: Sheriff Department");}
		if(PlayerInfo[playerid][pOrg] == 3) {TextDrawSetString(stats14[playerid], "Org: Carson Mafia");}
		if(PlayerInfo[playerid][pOrg] == 4) {TextDrawSetString(stats14[playerid], "Org: Cetvrta Organizacija");}
		if(PlayerInfo[playerid][pOrg] == 0) {TextDrawSetString(stats14[playerid], "Org: Ne");}
		TextDrawShowForPlayer(playerid, stats14[playerid]);
//------------------------------------------------------------------------------
		new rank[16];
		format(rank, sizeof(rank), "Rank: %i", PlayerInfo[playerid][pRank]);
		TextDrawSetString(stats15[playerid], rank);
		TextDrawShowForPlayer(playerid, stats15[playerid]);
//------------------------------------------------------------------------------
		new provedeno[32];
		format(provedeno, sizeof(provedeno), "Provedeno sati: %i", PlayerInfo[playerid][OrgSati]);
		TextDrawSetString(stats16[playerid], provedeno);
		TextDrawShowForPlayer(playerid, stats16[playerid]);
//------------------------------------------------------------------------------
		new dostave[32];
		format(dostave, sizeof(dostave), "Dostave: %i", PlayerInfo[playerid][OrgDostave]);
		TextDrawSetString(stats17[playerid], dostave);
		TextDrawShowForPlayer(playerid, stats17[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats18[playerid]);
//------------------------------------------------------------------------------
/*		new posao[32];
		format(posao, sizeof(posao), "Posao: %s", PlayerInfo[playerid][pJob]);
		TextDrawSetString(stats19[playerid], posao); */
		if(PlayerInfo[playerid][pJob] == 1) {TextDrawSetString(stats19[playerid], "Posao: Elektricar");				}
		if(PlayerInfo[playerid][pJob] == 0) {TextDrawSetString(stats19[playerid], "Posao: Ne");								}
		if(PlayerInfo[playerid][pJob] == 2) {TextDrawSetString(stats19[playerid], "Posao: Mlijekar");					}
		if(PlayerInfo[playerid][pJob] == 3) {TextDrawSetString(stats19[playerid], "Posao: Postar");						}
		if(PlayerInfo[playerid][pJob] == 4) {TextDrawSetString(stats19[playerid], "Posao: Rudar");						}
		if(PlayerInfo[playerid][pJob] == 5) {TextDrawSetString(stats19[playerid], "Posao: Farmer"); 					}
		if(PlayerInfo[playerid][pJob] == 6) {TextDrawSetString(stats19[playerid], "Posao: Uzgajivac droge");	}
		if(PlayerInfo[playerid][pJob] == 7) {TextDrawSetString(stats19[playerid], "Posao: Drvosjeca");				}
		TextDrawShowForPlayer(playerid, stats19[playerid]);
//------------------------------------------------------------------------------
		new skill[32];
		format(skill, sizeof(skill), "Skill: %i/500", PlayerInfo[playerid][JobSkill]);
		TextDrawSetString(stats20[playerid], skill);
		TextDrawShowForPlayer(playerid, stats20[playerid]);
//------------------------------------------------------------------------------
		new jobugovor[32];
		format(jobugovor, sizeof(jobugovor), "Ugovor: %i/10", PlayerInfo[playerid][JobUgovor]);
		TextDrawSetString(stats21[playerid], jobugovor);
		TextDrawShowForPlayer(playerid, stats21[playerid]);
//------------------------------------------------------------------------------
		new placa[32];
		format(placa, sizeof(placa), "Placa: $%i", PlayerInfo[playerid][JobPlaca]);
		TextDrawSetString(stats22[playerid], placa);
		TextDrawShowForPlayer(playerid, stats22[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats23[playerid]);
//------------------------------------------------------------------------------
		new vozilo1[32];
		format(vozilo1, sizeof(vozilo1), "Vozilo (1) ID: %i", PlayerInfo[playerid][Car1ID]);
		TextDrawSetString(stats24[playerid], vozilo1);
		TextDrawShowForPlayer(playerid, stats24[playerid]);
//------------------------------------------------------------------------------
		new vozilo2[32];
		format(vozilo2, sizeof(vozilo2), "Vozilo (2) ID: %i", PlayerInfo[playerid][Car2ID]);
		TextDrawSetString(stats25[playerid], vozilo2);
		TextDrawShowForPlayer(playerid, stats25[playerid]);
//------------------------------------------------------------------------------
		new kucastats[32];
		format(kucastats, sizeof(kucastats), "Kuca ID: %i", PlayerInfo[playerid][KucaID]);
		TextDrawSetString(stats26[playerid], kucastats);
		TextDrawShowForPlayer(playerid, stats26[playerid]);
//------------------------------------------------------------------------------
		new biznisstats[32];
		format(biznisstats, sizeof(biznisstats), "Biznis ID: %i", PlayerInfo[playerid][BiznisID]);
		TextDrawSetString(stats27[playerid], biznisstats);
		TextDrawShowForPlayer(playerid, stats27[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats28[playerid]);
//------------------------------------------------------------------------------
		new cigarete[32];
		format(cigarete, sizeof(cigarete), "Cigarete: %i/20", PlayerInfo[playerid][pCigarete]);
		TextDrawSetString(stats29[playerid], cigarete);
		TextDrawShowForPlayer(playerid, stats29[playerid]);
//------------------------------------------------------------------------------
		new kredit[32];
		format(kredit, sizeof(kredit), "Mob. Kredit: $%i", PlayerInfo[playerid][pKredit]);
		TextDrawSetString(stats30[playerid], kredit);
		TextDrawShowForPlayer(playerid, stats30[playerid]);
//------------------------------------------------------------------------------
		new ocn[32];
		format(ocn, sizeof(ocn), "OCN: %i", PlayerInfo[playerid][pOCN]);
		TextDrawSetString(stats31[playerid], ocn);
		TextDrawShowForPlayer(playerid, stats31[playerid]);
//------------------------------------------------------------------------------
		TextDrawShowForPlayer(playerid, stats32[playerid]);
		SendClientMessage(playerid,BOJA_NARANCASTA,"INFO: Da zatvorite stats ukucajte /stats");
	}
	else {
	    SetPVarInt(playerid,"stats", 0);
		TextDrawHideForPlayer(playerid, stats0[playerid]);
		TextDrawHideForPlayer(playerid, stats1[playerid]);
		TextDrawHideForPlayer(playerid, stats2[playerid]);
		TextDrawHideForPlayer(playerid, stats3[playerid]);
		TextDrawHideForPlayer(playerid, stats4[playerid]);
		TextDrawHideForPlayer(playerid, stats5[playerid]);
		TextDrawHideForPlayer(playerid, stats6[playerid]);
		TextDrawHideForPlayer(playerid, stats7[playerid]);
		TextDrawHideForPlayer(playerid, stats8[playerid]);
		TextDrawHideForPlayer(playerid, stats9[playerid]);
		TextDrawHideForPlayer(playerid, stats10[playerid]);
		TextDrawHideForPlayer(playerid, stats11[playerid]);
		TextDrawHideForPlayer(playerid, stats12[playerid]);
		TextDrawHideForPlayer(playerid, stats13[playerid]);
		TextDrawHideForPlayer(playerid, stats14[playerid]);
		TextDrawHideForPlayer(playerid, stats15[playerid]);
		TextDrawHideForPlayer(playerid, stats16[playerid]);
		TextDrawHideForPlayer(playerid, stats17[playerid]);
		TextDrawHideForPlayer(playerid, stats18[playerid]);
		TextDrawHideForPlayer(playerid, stats19[playerid]);
		TextDrawHideForPlayer(playerid, stats20[playerid]);
		TextDrawHideForPlayer(playerid, stats21[playerid]);
		TextDrawHideForPlayer(playerid, stats22[playerid]);
		TextDrawHideForPlayer(playerid, stats23[playerid]);
		TextDrawHideForPlayer(playerid, stats24[playerid]);
		TextDrawHideForPlayer(playerid, stats25[playerid]);
		TextDrawHideForPlayer(playerid, stats26[playerid]);
		TextDrawHideForPlayer(playerid, stats27[playerid]);
		TextDrawHideForPlayer(playerid, stats28[playerid]);
		TextDrawHideForPlayer(playerid, stats29[playerid]);
		TextDrawHideForPlayer(playerid, stats30[playerid]);
		TextDrawHideForPlayer(playerid, stats31[playerid]);
		TextDrawHideForPlayer(playerid, stats32[playerid]);
	}
	return 1;
}
ALTCOMMAND:kreirajbiznis->createbusiness;
CMD:createbusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337){
	new idbiznisa, tip, cijena;
	if(sscanf(params, "ddd", idbiznisa, tip, cijena)) return SendClientMessage(playerid, COLOR_ADMWARN, "{FF0000}[VR-RPG] => "STRING_GRAY"/kreirajbiznis [id biznisa] [tip] [cijena]");

	//Otvara fajl biznisa i uspisuje podatke (Kao kod kuce) - Copy-paste hehehe
	new stringer[128];
	format(stringer, sizeof(stringer), "Biznisi/%i.ini", idbiznisa);

	new INI:biznis = INI_Open(stringer);
	INI_SetTag(biznis, "biznis");
	INI_WriteInt(biznis,"ID",idbiznisa);
	INI_WriteInt(biznis,"Cijena",cijena);
	INI_WriteString(biznis,"Vlasnik","Nitko");
	INI_WriteInt(biznis,"Blagajna",0);
	INI_WriteInt(biznis,"Tip",tip); // Market(0), Marketing Agencija(1), Kafic(2), Bar(3),Pizzeria(4).. Bit ce jos
	INI_WriteInt(biznis,"Prodano",0);

	//Znaci zaboravio sam sta treba radit tako da radim copy paste lol xD Don't Worry, I know what I'm doing!
	new Float:x_biz, Float:y_biz, Float:z_biz;
	GetPlayerPos(playerid, x_biz, y_biz, z_biz);
	INI_WriteFloat(biznis,"UlazX",x_biz);
	INI_WriteFloat(biznis,"UlazY",y_biz);
	INI_WriteFloat(biznis,"UlazZ",z_biz);
	SendClientMessage(playerid, COLOR_ADMWARN,"[VR-RPG]:"STRING_GRAY" Biznis je uspjesno napravljen. Sada ukucajte "STRING_ADMWARN"'/resetbiznisa'"STRING_GRAY" da se pojavi biznis.");
	INI_Close(biznis);
	}
	else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Morate biti admin da koristite ovu komandu!"); }
	return 1;
}
CMD:createhouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 1337){
	//Gledali jeli admin unio sve parametre
	new idkuce, velicina, cijena;
	if(sscanf(params, "ddd", idkuce, velicina, cijena)) return SendClientMessage(playerid, COLOR_ADMWARN, "{FF0000}[VR-RPG] => "STRING_GRAY"/kreirajkucu [id kuce] [velicina] [cijena]");
    new string[128];
    format(string, sizeof(string), "Kuce/%i.ini", idkuce);

	//Otvara fajl kuce i upisuje podatke
	new INI:house = INI_Open(string);
	INI_SetTag(house,"data");
	INI_WriteInt(house,"ID",idkuce);
	INI_WriteInt(house,"Cijena",cijena);
	INI_WriteString(house,"Vlasnik","Nitko");
	INI_WriteInt(house,"Locked",0);
	INI_WriteInt(house,"Oruzje",0);
	INI_WriteInt(house,"Prodano",0);
	INI_WriteInt(house,"Novac",0);
	INI_WriteInt(house,"Ammo",0);
	INI_WriteInt(house,"Velicina",velicina); //Mala, Srednja, Luksuzna

	new Float:x_ch, Float:y_ch, Float:z_ch;
	GetPlayerPos(playerid, x_ch, y_ch, z_ch);
	INI_WriteFloat(house,"UlazX",x_ch);
	INI_WriteFloat(house,"UlazY",y_ch);
	INI_WriteFloat(house,"UlazZ",z_ch);

	SendClientMessage(playerid, COLOR_ADMWARN,"[VR-RPG]:"STRING_GRAY" Kuca je uspjesno napravljena. Sada ukucajte "STRING_ADMWARN"'/resetkuca'"STRING_GRAY" da se pojavi kuca.");
	INI_Close(house);
}
else { SendClientMessage(playerid,COLOR_ADMWARN,"ERROR: Morate biti admin da koristite ovu komandu!"); }
	return 1;
}
CMD:ahelp(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, -1,"Za ovu komandu je potreban admin level!");
 	SendClientMessage(playerid, -1, "____________________________________________________________________");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 1: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 2: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 3: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 4: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 5: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 6: No commands yet!");
    }
   	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
        SendClientMessage(playerid, COLOR_FADE, "Level 1337: /givemoney -");
    }
 	SendClientMessage(playerid, -1, "____________________________________________________________________");
 	return 1;
}

CMD:help(playerid, params[])
{
    SendClientMessage(playerid, COLOR_LIGHTBLUE,"------------------------------------------------------------");
    SendClientMessage(playerid, COLOR_GRAD2," // ");
    SendClientMessage(playerid, COLOR_LIGHTBLUE,"------------------------------------------------------------");
    return 1;
}
CMD:givemoney(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 0 && PlayerInfo[playerid][pDuty] == 1){
	new targetid,kolicina,string[170];
	if(sscanf(params, "ui", targetid, kolicina)) return SendClientMessage(playerid, COLOR_YELLOW, "[VR:RPG] "STRING_GRAY"Koristenje: /givemoney [id/ime igraca] [kolicina novca]");
	if(IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: To ime ne postoji ili igrac nije online.");
	GivePlayerCash(targetid, kolicina);

	for(new aon = 0; aon < MAX_PLAYERS; aon++){
		if(PlayerInfo[aon][pAdmin] != 0 && PlayerInfo[aon][pDuty]){
		format(string, sizeof(string), "ADMIN WARN: Admin %s je dao $%d igracu %s.", Name(playerid), kolicina, Name(targetid));
		SendClientMessage(aon, COLOR_ADMWARN, string);
		AdminLog(string);
		}
	}

	}
	else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Morate biti admin da duznosti da koristite ovu komandu"); }

	return 1;
}
CMD:kupi(playerid,params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 376.4330,-68.1149,1001.5151))
	{
		ShowPlayerDialog(playerid, DIALOG_KUPI, DIALOG_STYLE_LIST, "Kupi hranu", "$50 - Pecena kokos\n$35 - Big Hamburger\n$25 - Mini Hamburger\n$10 - Pomfrit", "Kupi", "Odustani");
			}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1.6822,-28.4991,1003.5494)) // PROMIJENI KORDE!
	{
	    ShowPlayerDialog(playerid, DIALOG_KUPI_TRG, DIALOG_STYLE_LIST, "Kupi proizvod", "$150 - Mobitel\n$10 - Cigarete\n$50 - Bon\n$35 - Bon", "Kupi", "Odustani");
			}
	return 1;
}
forward DrogaRaste(playerid);
public DrogaRaste(playerid)
{
	if(DrogaInfo[PlayerInfo[playerid][DrogaID]][dMinuta] > 1){ DrogaInfo[PlayerInfo[playerid][DrogaID]][dMinuta]--; }
	else{
		DrogaInfo[PlayerInfo[playerid][DrogaID]][dGrown] = 1;
	}
	return 1;
}
forward AdminChat(achat[]);
public AdminChat(achat[])
{
	new entry[256],
	year,
	month,
	day,
	hour,
	minute,
	second;

	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%d-%d-%d | %d:%d:%d || %s\n", day, month, year, hour, minute, second, achat);

	new File:hFile;
	hFile = fopen("Logs/Admin_Chat.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
	return 1;
}
forward AdminLog(admwarn[]);
public AdminLog(admwarn[])
{
	new entry[256],
	year,
	month,
	day,
	hour,
	minute,
	second;

	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%d-%d-%d | %d:%d:%d || %s\n", day, month, year, hour, minute, second, admwarn);

	new File:hFile;
	hFile = fopen("Logs/Admin_Warn.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
	return 1;
}
forward FixPlayerCam(playerid);
public FixPlayerCam(playerid)
{
	InterpolateCameraPos(playerid, -642.6710, 2694.2913, 74.5214, -637.2400, 2693.7300, 73.7800, 5000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, -643.6403, 2694.5234, 74.4759, -638.2200, 2693.9399, 73.7200, 5000, CAMERA_MOVE);
}
forward farma_mlijeko2(playerid);
public farma_mlijeko2(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid, COLOR_YELLOW, " ");
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste istovarili mlijeko na privatnu farmu. Vratite se nazad na mjesto oznaceno na karti.");
	SetPlayerCheckpoint(playerid, 386.9487,1125.1670,11.4559, 4.0);
	return 1;
}
forward farma_mlijeko1(playerid);
public farma_mlijeko1(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid, COLOR_YELLOW, " ");
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste istovarili mlijeko u mlijekari. Idite to mjesta oznacenog "STRING_RED"crveno"STRING_YELLOW" na karti.");
	SetPlayerCheckpoint(playerid, -1044.2600,1564.1252,33.5436, 4.0);
	return 1;
}
forward muznja(playerid);
public muznja(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno si izmuzao kravu. Sada odnesi to mlijeko do kamiona na karti.");
	zkrava1 = 0;
	SetPlayerAttachedObject(playerid, 0, 1328, 6, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5);
	SetPlayerCheckpoint(playerid, 401.9136, 1160.9579, 7.7158, 10.0);
	SetPVarInt(playerid, "ima_mlijeko", 1);
	return 1;
}
forward boca(playerid);
public boca(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}
forward VrijemeHrana(playerid);
public VrijemeHrana(playerid)
{

}
public MyTimer (playerid)
{
	TextDrawHideForPlayer(playerid, Welcome0);
	TextDrawHideForPlayer(playerid, Welcome1);
	TextDrawHideForPlayer(playerid, Welcome2);
	TextDrawHideForPlayer(playerid, Welcome3);
	TextDrawHideForPlayer(playerid, Welcome4);
	TextDrawHideForPlayer(playerid, Welcome5);
	TextDrawHideForPlayer(playerid, Welcome6);
	TextDrawHideForPlayer(playerid, Welcome7);
	TextDrawHideForPlayer(playerid, Welcome8);
	TextDrawHideForPlayer(playerid, Welcome9);
	TextDrawHideForPlayer(playerid, Welcome10);
	TextDrawHideForPlayer(playerid, Welcome11);
	TextDrawHideForPlayer(playerid, Welcome12);
	TextDrawHideForPlayer(playerid, Welcome13);
	TextDrawHideForPlayer(playerid, Welcome14);
	TextDrawHideForPlayer(playerid, Welcome15);

	if(fexist(UserPath(playerid)))
	{
			INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,"Vintage Republic RPG/DM",""STRING_ADMWARN"//------------------------------------//"STRING_WHITE"\n\nDobrodosli natrag na Vintage Republic!\n\n"STRING_ADMWARN"Racun:"STRING_WHITE" Vi imate registriran racun\n\nUnesite lozinku da krenete s igrom\n\n"STRING_ADMWARN"//------------------------------------//", "Login", "Kick");
	}
	else
	{
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,"Vintage Republic RPG/DM",""STRING_ADMWARN"//------------------------------------//"STRING_WHITE"\n\nDobrodosli natrag na Vintage Republic!\n\n"STRING_ADMWARN"Racun:"STRING_WHITE" Vas racun nije registriran\n\nUnesite lozinku koju zelite koristiti\n\n"STRING_ADMWARN"//------------------------------------//","Register","Kick");
	}
}
public OnPlayerEnterCheckpoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 4.0, 386.9487,1125.1670,11.4559)){
	if(IsPlayerInVehicle(playerid, farm[10]) || IsPlayerInVehicle(playerid, farm[11]) || IsPlayerInVehicle(playerid, farm[12]) || IsPlayerInVehicle(playerid, farm[13]) || IsPlayerInVehicle(playerid, farm[14])){
	DisablePlayerCheckpoint(playerid);
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, COLOR_YELLOW, " ");
		if(PlayerInfo[playerid][JobUgovor] < 10){
		PlayerInfo[playerid][JobUgovor]	= PlayerInfo[playerid][JobUgovor]+1;
		}
		if(PlayerInfo[playerid][JobSkill] < 100){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$600");
		PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+600;
		}
		if(PlayerInfo[playerid][JobSkill] >= 100){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$700");
		PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+700;
		}
		if(PlayerInfo[playerid][JobSkill] >= 200){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$800");
		PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+800;
		}
		if(PlayerInfo[playerid][JobSkill] >= 300){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$900");
		PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+900;
		}
		if(PlayerInfo[playerid][JobSkill] >= 400){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$1000");
		PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+1000;
		}
		if(PlayerInfo[playerid][JobSkill] == 500){
		SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste dostavili mlijeko te tako zaradili "STRING_WHITE"$1100");
		PlayerInfo[playerid][JobPlaca] = 	PlayerInfo[playerid][JobPlaca]+1100;
		}
	}
	}
	if(IsPlayerInRangeOfPoint(playerid, 4.0, -1044.2600,1564.1252,33.5436)){
	if(IsPlayerInVehicle(playerid, farm[10]) || IsPlayerInVehicle(playerid, farm[11]) || IsPlayerInVehicle(playerid, farm[12]) || IsPlayerInVehicle(playerid, farm[13]) || IsPlayerInVehicle(playerid, farm[14])){
		SetTimerEx("farma_mlijeko2", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "Istovar mlijeka...", 5000, 4);
	}
	}
	if(IsPlayerInRangeOfPoint(playerid, 4.0, 599.9676,1246.9285,11.7188)){
	if(IsPlayerInVehicle(playerid, farm[10]) || IsPlayerInVehicle(playerid, farm[11]) || IsPlayerInVehicle(playerid, farm[12]) || IsPlayerInVehicle(playerid, farm[13]) || IsPlayerInVehicle(playerid, farm[14])){
		SetTimerEx("farma_mlijeko1", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "Istovar mlijeka...", 5000, 4);
	}
	}
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 401.9136, 1160.9579, 7.7158)){
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, COLOR_YELLOW, "Stani kraj jednog auta i ukucaj "STRING_WHITE"/utovari");
	}
	if(IsPlayerInAnyVehicle(playerid) == 1){
	//--{ ZETVA #1 }--//
	if(posijano == 1){
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.18665, 1152.49268, 10)){
	SetObjectPos(zito[1], 263.18665, 1152.49268, 0);
	SetPlayerCheckpoint(playerid, 257.65616, 1152.64795, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.65616, 1152.64795, 10)){
	SetObjectPos(zito[2], 257.65616, 1152.64795, 0);
	SetPlayerCheckpoint(playerid, 251.55481, 1152.73364, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 251.55481, 1152.73364, 10)){
	SetObjectPos(zito[3], 251.55481, 1152.73364, 0);
	SetPlayerCheckpoint(playerid, 245.63452, 1152.74561, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 245.63452, 1152.74561, 10)){
	SetObjectPos(zito[4], 245.63452, 1152.74561, 0);
	SetPlayerCheckpoint(playerid, 239.31229, 1152.66565, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 239.31229, 1152.66565, 13)){
	SetObjectPos(zito[5], 239.31229, 1152.66565, 0);
	SetPlayerCheckpoint(playerid, 233.61259, 1152.73572, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 233.61259, 1152.73572, 13)){
	SetObjectPos(zito[6], 233.61259, 1152.73572, 0);
	SetPlayerCheckpoint(playerid, 227.75075, 1152.76831, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 227.75075, 1152.76831, 13)){
	SetObjectPos(zito[7], 227.75075, 1152.76831, 0);
	SetPlayerCheckpoint(playerid, 226.64233, 1140.86646, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 226.64233, 1140.86646, 13)){
	SetObjectPos(zito[14], 226.64233, 1140.86646, 0);
	SetPlayerCheckpoint(playerid, 233.06183, 1140.54419, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 233.06183, 1140.54419, 13)){
	SetObjectPos(zito[13], 233.06183, 1140.54419, 0);
	SetPlayerCheckpoint(playerid, 238.96049, 1140.59009, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 238.96049, 1140.59009, 13)){
	SetObjectPos(zito[12], 238.96049, 1140.59009, 0);
	SetPlayerCheckpoint(playerid, 244.98587, 1140.63721, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 244.98587, 1140.63721, 13)){
	SetObjectPos(zito[11], 244.98587, 1140.63721, 0);
	SetPlayerCheckpoint(playerid, 250.83134, 1140.37573, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 250.83134, 1140.37573, 11.5)){
	SetObjectPos(zito[10], 250.83134, 1140.37573, 0);
	SetPlayerCheckpoint(playerid, 257.38342, 1140.08008, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.38342, 1140.08008, 13)){
	SetObjectPos(zito[9], 257.38342, 1140.08008, 0);
	SetPlayerCheckpoint(playerid, 263.09848, 1140.21887, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.09848, 1140.21887, 13)){
	SetObjectPos(zito[8], 263.09848, 1140.21887, 0);
	SetPlayerCheckpoint(playerid, 263.41553, 1125.63928, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.41553, 1125.63928, 13)){
	SetObjectPos(zito[15], 263.41553, 1125.63928, 0);
	SetPlayerCheckpoint(playerid, 257.07257, 1126.09131, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.07257, 1126.09131, 13)){
	SetObjectPos(zito[16], 257.07257, 1126.09131, 0);
	SetPlayerCheckpoint(playerid, 250.30775, 1125.92224, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 250.30775, 1125.92224, 13)){
	SetObjectPos(zito[17], 250.30775, 1125.92224, 0);
	SetPlayerCheckpoint(playerid, 244.39594, 1126.00854, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 244.39594, 1126.00854, 13)){
	SetObjectPos(zito[18], 244.39594, 1126.00854, 0);
	SetPlayerCheckpoint(playerid, 238.81793, 1125.90967, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 238.81793, 1125.90967, 13)){
	SetObjectPos(zito[19], 238.81793, 1125.90967, 0);
	SetPlayerCheckpoint(playerid, 232.89105, 1125.87305, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 232.89105, 1125.87305, 13)){
	SetObjectPos(zito[20], 232.89105, 1125.87305, 0);
	SetPlayerCheckpoint(playerid, 226.41110, 1126.05615, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 226.41110, 1126.05615, 13)){
	SetObjectPos(zito[21], 226.41110, 1126.05615, 0);
	if(posijano == 1){
	SetPVarInt(playerid, "zapoceo", 0);
	SetPVarInt(playerid, "zetva", 1);
	posijano = 0;
	zauzeto = 0;
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste uradili zetvu zita te tako zaradili "STRING_WHITE"$400!");
	}
	}
  }
	if(posijano == 0){
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.18665, 1152.49268, 10)){
	SetObjectPos(zito[1], 263.18665, 1152.49268, 10);
	SetPlayerCheckpoint(playerid, 257.65616, 1152.64795, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.65616, 1152.64795, 10)){
	SetObjectPos(zito[2], 257.65616, 1152.64795, 10);
	SetPlayerCheckpoint(playerid, 251.55481, 1152.73364, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 251.55481, 1152.73364, 10)){
	SetObjectPos(zito[3], 251.55481, 1152.73364, 10);
	SetPlayerCheckpoint(playerid, 245.63452, 1152.74561, 10, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 245.63452, 1152.74561, 10)){
	SetObjectPos(zito[4], 245.63452, 1152.74561, 10);
	SetPlayerCheckpoint(playerid, 239.31229, 1152.66565, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 239.31229, 1152.66565, 13)){
	SetObjectPos(zito[5], 239.31229, 1152.66565, 10);
	SetPlayerCheckpoint(playerid, 233.61259, 1152.73572, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 233.61259, 1152.73572, 13)){
	SetObjectPos(zito[6], 233.61259, 1152.73572, 10);
	SetPlayerCheckpoint(playerid, 227.75075, 1152.76831, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 227.75075, 1152.76831, 13)){
	SetObjectPos(zito[7], 227.75075, 1152.76831, 10);
	SetPlayerCheckpoint(playerid, 263.09848, 1140.21887, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.09848, 1140.21887, 13)){
	SetObjectPos(zito[8], 263.09848, 1140.21887, 10);
	SetPlayerCheckpoint(playerid, 257.38342, 1140.08008, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.38342, 1140.08008, 13)){
	SetObjectPos(zito[9], 257.38342, 1140.08008, 10);
	SetPlayerCheckpoint(playerid, 250.83134, 1140.37573, 11, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 250.83134, 1140.37573, 11.5)){
	SetObjectPos(zito[10], 250.83134, 1140.37573, 10);
	SetPlayerCheckpoint(playerid, 244.98587, 1140.63721, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 244.98587, 1140.63721, 13)){
	SetObjectPos(zito[11], 244.98587, 1140.63721, 10);
	SetPlayerCheckpoint(playerid, 238.96049, 1140.59009, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 238.96049, 1140.59009, 13)){
	SetObjectPos(zito[12], 238.96049, 1140.59009, 10);
	SetPlayerCheckpoint(playerid, 233.06183, 1140.54419, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 233.06183, 1140.54419, 13)){
	SetObjectPos(zito[13], 233.06183, 1140.54419, 10);
	SetPlayerCheckpoint(playerid, 226.64233, 1140.86646, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 226.64233, 1140.86646, 13)){
	SetObjectPos(zito[14], 226.64233, 1140.86646, 10);
	SetPlayerCheckpoint(playerid, 263.41553, 1125.63928, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 263.41553, 1125.63928, 13)){
	SetObjectPos(zito[15], 263.41553, 1125.63928, 10);
	SetPlayerCheckpoint(playerid, 257.07257, 1126.09131, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 257.07257, 1126.09131, 13)){
	SetObjectPos(zito[16], 257.07257, 1126.09131, 10);
	SetPlayerCheckpoint(playerid, 250.30775, 1125.92224, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 250.30775, 1125.92224, 13)){
	SetObjectPos(zito[17], 250.30775, 1125.92224, 10);
	SetPlayerCheckpoint(playerid, 244.39594, 1126.00854, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 244.39594, 1126.00854, 13)){
	SetObjectPos(zito[18], 244.39594, 1126.00854, 10);
	SetPlayerCheckpoint(playerid, 238.81793, 1125.90967, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 238.81793, 1125.90967, 13)){
	SetObjectPos(zito[19], 238.81793, 1125.90967, 10);
	SetPlayerCheckpoint(playerid, 232.89105, 1125.87305, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 232.89105, 1125.87305, 13)){
	SetObjectPos(zito[20], 232.89105, 1125.87305, 10);
	SetPlayerCheckpoint(playerid, 226.41110, 1126.05615, 13, 3.0);
	}
	//---//
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 226.41110, 1126.05615, 13)){
	SetObjectPos(zito[21], 226.41110, 1126.05615, 10);
	SetPVarInt(playerid, "zapoceo", 0);
	DisablePlayerCheckpoint(playerid);
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
	if(posijano == 0 && GetPVarInt(playerid, "zetva") == 0){
	posijano = 1;
	if(PlayerInfo[playerid][JobSkill] >= 100) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$550");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+550;
	PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	if(PlayerInfo[playerid][JobSkill] >= 200) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$650");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+650;
	PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	if(PlayerInfo[playerid][JobSkill] >= 300) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$750");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+750;
	PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	if(PlayerInfo[playerid][JobSkill] >= 400) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$850");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+850;
	PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	if(PlayerInfo[playerid][JobSkill] == 500) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$1000");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+1000;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	if(PlayerInfo[playerid][JobSkill] < 100) {
	SendClientMessage(playerid, COLOR_YELLOW, "Uspjesno ste posijali zito te tako zaradili "STRING_WHITE"$400");
	PlayerInfo[playerid][JobPlaca] = PlayerInfo[playerid][JobPlaca]+400;
	PlayerInfo[playerid][JobSkill] = PlayerInfo[playerid][JobSkill]+1;
	if(PlayerInfo[playerid][JobUgovor] < 10) { PlayerInfo[playerid][JobUgovor] = PlayerInfo[playerid][JobUgovor]+1; }
	zauzeto = 0;
	}
	}
	}
	}
	if(GetPVarInt(playerid, "zetva") == 1){
	SetPVarInt(playerid, "zetva", 0);
	}
	}
		return 1;
	}
/*	if(IsPlayerInCheckpoint(playerid) && IsPlayerInRangeOfPoint(playerid, 2.0, 263.18665, 1152.49268, 10) && IsPlayerInAnyVehicle(playerid)){ //Promijeniti na neko drugo auto
	SetObjectPos(objectid, 263.18665, 1152.49268, 10);
	SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, 2.0);
	}
	new Float:x, Float:y, Float:z;
	GetVehiclePos(idvozila[PlayerInfo[playerid][Car1ID]], x, y, z);
	if(IsPlayerInCheckpoint(playerid) && IsPlayerInRangeOfPoint(playerid, 6.0, x, y, z)){
	DisablePlayerCheckpoint(playerid);
	} */
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
		/*if(IsPlayerInRangeOfPoint(playerid, Float:range, Float:x, Float:y, Float:z))
		if(HOLDING(KEY_YES)){
		ApplyAnimation(playerid, "CHAINSAW", "IDLE_csaw", 4.1, 1, 1, 1, 0, 0, 1);
		}
		if ((oldkeys & KEY_YES) && !(newkeys & KEY_YES)){
		ClearAnimations(playerid);
		} */
    if(newkeys & KEY_SECONDARY_ATTACK)
    {
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 232.4430,1822.4905,7.4141)){
		SetPlayerPos(playerid, 156.1201,1439.9026,11.1314);
		SetPlayerVirtualWorld(playerid, 0);
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.0, 156.1201,1439.9026,11.1314)){
		SetPlayerPos(playerid, 232.4430,1822.4905,7.4141);
		SetPlayerVirtualWorld(playerid, 2500);
		}
		//++++++++++++++++++++[VEHICLE DEALERSHIP]++++++++++++++++++++++++++++++++|| Ovdje je skripta za ulaz u autosalon posto nije obican Biznis
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -311.1066,1303.3275,54.5)){
			new Float:x11, Float:y11, Float:z11;
      GetPlayerPos(playerid, x11, y11, z11);
      SetPVarFloat(playerid,"xpos",x11); // Sprema koordinate prije ulaska u radnju
    	SetPVarFloat(playerid,"ypos",y11); // Sprema koordinate prije ulaska u radnju
    	SetPVarFloat(playerid,"zpos",z11); // Sprema koordinate prije ulaska u radnju

			SetPlayerInterior(playerid, 3);
    	SetPlayerVirtualWorld(playerid, 888);
			SetPlayerPos(playerid, 354.1722,157.9130,1025.7964);
			CreatePickup(1239, 1, 356.3181,152.1401,1025.7891, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da kupite automobil ukucajte "STRING_WHITE"/kupiauto", COLOR_GREEN, 356.3181,152.1401,1025.7891, 10.0, GetPlayerVirtualWorld(playerid), 1);
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      for(new al = 0; al < MAX_BUSINESS; al++){
			if(IsPlayerInRangeOfPoint(playerid,2.0,BiznisInfo[al][bUlazX],BiznisInfo[al][bUlazY],BiznisInfo[al][bUlazZ])){

      new Float:x22, Float:y22, Float:z22;
      GetPlayerPos(playerid, x22, y22, z22);
      SetPVarFloat(playerid,"xpos",x22); // Sprema koordinate prije ulaska u radnju
    	SetPVarFloat(playerid,"ypos",y22); // Sprema koordinate prije ulaska u radnju
    	SetPVarFloat(playerid,"zpos",z22); // Sprema koordinate prije ulaska u radnju

    	SetPlayerVirtualWorld(playerid, al+100);
			//_______________________________________________________________________
    	if(BiznisInfo[al][bTip] == 0){ //Prodavnica
    	SetPlayerInterior(playerid, 10);
    	SetPlayerPos(playerid,6.091179,-29.271898,1003.549438);
			CreatePickup(1239, 1, 1.7765,-29.0135,1003.5494, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da kupite ukucajte "STRING_WHITE"/kupi", COLOR_GREEN, 1.7765,-29.0135,1003.5494, 10.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
    	if(BiznisInfo[al][bTip] == 1){ //Marketing Agencija
			SetPlayerInterior(playerid, 3);
			SetPlayerPos(playerid, 1494.325195,1304.942871,1093.289062);
			CreatePickup(1239, 1, 1491.1897,1307.3757,1093.2891, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da napisete oglas ukucajte "STRING_WHITE"/oglas", COLOR_GREEN, 1491.1897,1307.3757,1093.2891,10.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
		  }
    	if(BiznisInfo[al][bTip] == 2){ //Fast-Food
			SetPlayerInterior(playerid, 10);
			SetPlayerPos(playerid, 363.8795,-74.2501,1001.5078);
			CreatePickup(1239, 1, 377.5997,-68.2366,1001.5151, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da kupite hranu ukucajte "STRING_WHITE"/fastfood",COLOR_GREEN, 377.5997,-68.2366,1001.5151, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
    	if(BiznisInfo[al][bTip] == 3){ //Bar
			SetPlayerInterior(playerid, 11);
			SetPlayerPos(playerid, 501.980987,-69.150199,998.757812);
			CreatePickup(1239, 1, 495.6192,-75.8747,998.7578, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da kupite pice ukucajte "STRING_WHITE"/drink", COLOR_GREEN, 495.6192,-75.8747,998.7578, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
		  }
			if(BiznisInfo[al][bTip] == 4){ //Restoran
			SetPlayerInterior(playerid, 1);
			SetPlayerPos(playerid, 681.5786,-451.4769,-25.6172);
			CreatePickup(1239, 1, 681.5031,-453.8319,-25.6172, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Da kupite hranu ukucajte "STRING_WHITE"/restoran", COLOR_GREEN, 681.5031,-453.8319,-25.6172, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
		  }
			if(BiznisInfo[al][bTip] == 5){ //Banka BRAJO
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, 2315.952880,-1.618174,26.742187);
			CreatePickup(1239, 1, 2316.6213,-7.5301,26.7422, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Ukucajte "STRING_WHITE"/banka"STRING_GREEN" da\nvidite opcije", COLOR_GREEN, 2316.6213,-7.5301,26.7422, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
		  }
			if(BiznisInfo[al][bTip] == 6){ //Weapon Shop (Oruzarnica)
			SetPlayerInterior(playerid, 6);
			SetPlayerPos(playerid, 316.524993,-167.706985,999.593750);
			CreatePickup(1239, 1, 312.1584,-165.8447,999.6010, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Kucajte "STRING_WHITE"/buyweapon "STRING_GREEN"da kupite oruzje", COLOR_GREEN, 312.1584,-165.8447,999.6010,15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
			if(BiznisInfo[al][bTip] == 7){ //Nocni Klub
			SetPlayerInterior(playerid, 17);
			SetPlayerPos(playerid, 493.390991,-22.722799,1000.679687);
			CreatePickup(1239, 1, 499.9700,-20.5780,1000.6797, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Kucajte "STRING_WHITE"/nightclub"STRING_GREEN" da vidite opcije", COLOR_GREEN, 499.9700,-20.5780,1000.6797, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
			if(BiznisInfo[al][bTip] == 8){ //Sex Shop
			SetPlayerInterior(playerid, 3);
			SetPlayerPos(playerid, -100.2898,-24.9632,1000.7188);
			CreatePickup(1239, 1, -105.7380,-11.1153,1000.7188, GetPlayerVirtualWorld(playerid));
			Create3DTextLabel("Kucajte "STRING_WHITE"/sexshop"STRING_GREEN" da vidite opcije", COLOR_GREEN, -105.7380,-11.1153,1000.7188, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
			if(BiznisInfo[al][bTip] == 9){ //Skin Shop
			SetPlayerInterior(playerid, 5);
			SetPlayerPos(playerid, 226.293991,-7.431529,1002.210937);
			CreatePickup(1239, 1, 206.6480,-7.3187,1001.2109, GetPlayerVirtualWorld(playerid)); //Ajde brate dojadilo mi copy-paste vise lol
			Create3DTextLabel("Kucajte "STRING_WHITE"/kupiskin"STRING_GREEN" da kupite novu odjecu", COLOR_GREEN, 206.6480,-7.3187,1001.2109, 15.0, GetPlayerVirtualWorld(playerid), 1);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
			if(BiznisInfo[al][bTip] == 10){ //Crpka (Pumpa)
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, 663.836242,-575.605407,16.343263);
			SendClientMessage(playerid,COLOR_GREEN,"Da izadjete iz radnje kucajte "STRING_WHITE"/exit.");
			}
		}
		}
  		for(new ul = 0; ul < MAX_HOUSE; ul++){
		if(IsPlayerInRangeOfPoint(playerid,2.0,KucaInfo[ul][kUlazX],KucaInfo[ul][kUlazY],KucaInfo[ul][kUlazZ])){
		if(KucaInfo[ul][kLocked] == 0 || KucaInfo[ul][kID] == PlayerInfo[playerid][KucaID]){

        new Float:x_uk, Float:y_uk, Float:z_uk;
        GetPlayerPos(playerid, x_uk, y_uk, z_uk);
        SetPVarFloat(playerid,"xpos",x_uk); // Sprema koordinate prije ulaska u kucu
    	SetPVarFloat(playerid,"ypos",y_uk); // Sprema koordinate prije ulaska u kucu
    	SetPVarFloat(playerid,"zpos",z_uk); // Sprema koordinate prije ulaska u kucu

		SetPlayerVirtualWorld(playerid, ul);
		if(KucaInfo[ul][kVelicina] == 0){
		SetPlayerInterior(playerid, 0);
   		SetPlayerPos(playerid,1193.1779,2768.2275,-13.1560);
		}
		if(KucaInfo[ul][kVelicina] == 1){
		SetPlayerInterior(playerid, 12);
   		SetPlayerPos(playerid,444.646911,508.239044,1001.419494);
   		}
   		if(KucaInfo[ul][kVelicina] == 2){
        SetPlayerInterior(playerid, 3);
        SetPlayerPos(playerid,2496.049804,-1695.238159,1014.742187);
		}
		if(KucaInfo[ul][kVelicina] == 3){
		SetPlayerInterior(playerid, 12);
        SetPlayerPos(playerid,2324.419921,-1145.568359,1050.710083);
		}
   		SendClientMessage(playerid,COLOR_GREEN,"INFO: Da napustite kucu ukucajte "STRING_GRAY"/exit");
		}
  		else { GameTextForPlayer(playerid, "Zakljucano!", 2500, 4); }
		}
	  	}
    }
    return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	TextDrawHideForPlayer(playerid, speedbar0);
	TextDrawHideForPlayer(playerid, speedbar1);
	TextDrawHideForPlayer(playerid, speedbar2);
	TextDrawHideForPlayer(playerid, speedbar3);
	TextDrawHideForPlayer(playerid, speedbar4);

	PlayerTextDrawHide(playerid, speedbar5[playerid]);
	PlayerTextDrawHide(playerid, speedbar6[playerid]);
	PlayerTextDrawHide(playerid, speedbar7[playerid]);
	PlayerTextDrawHide(playerid, speedbar8[playerid]);

	KillTimer(speedtimer[playerid]);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
     if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
     {
        TextDrawShowForPlayer(playerid, speedbar0);
				TextDrawShowForPlayer(playerid, speedbar1);
				TextDrawShowForPlayer(playerid, speedbar2);
				TextDrawShowForPlayer(playerid, speedbar3);
				TextDrawShowForPlayer(playerid, speedbar4);

			  PlayerTextDrawSetString(playerid, speedbar6[playerid], GetVehicleName(GetPlayerVehicleID(playerid)));
				PlayerTextDrawShow(playerid, speedbar5[playerid]);
				PlayerTextDrawShow(playerid, speedbar6[playerid]);
				PlayerTextDrawShow(playerid, speedbar7[playerid]);
				PlayerTextDrawShow(playerid, speedbar8[playerid]); //

        speedtimer[playerid] = SetTimerEx("speedometer", 255, true, "i", playerid);

				if(IsPlayerInVehicle(playerid, farm[10]) || IsPlayerInVehicle(playerid, farm[11]) ||IsPlayerInVehicle(playerid, farm[12]) || IsPlayerInVehicle(playerid, farm[13]) || IsPlayerInVehicle(playerid, farm[14])){
				if(GetPVarInt(playerid, "utovario_mlijeko")){
				SetPlayerCheckpoint(playerid, 599.9676,1246.9285,11.7188, 4.0);
				SendClientMessage(playerid, COLOR_YELLOW, "Istovarite mlijeko kod mlijekare.");
				}
				else { SendClientMessage(playerid, COLOR_ADMWARN, "ERROR: Trebate utovariti mlijeko da vozite ovaj kamion");
				RemovePlayerFromVehicle(playerid);
				}
				}
				if(GetPlayerVehicleID(playerid) == farm[1] && GetPVarInt(playerid, "zapoceo") || GetPlayerVehicleID(playerid) == farm[2] && GetPVarInt(playerid, "zapoceo") || GetPlayerVehicleID(playerid) == farm[3] && GetPVarInt(playerid, "zapoceo")){
				SendClientMessage(playerid, COLOR_YELLOW, "Mjesto zetve vam je oznaceno na karti.");
				SetPlayerCheckpoint(playerid, 263.18665, 1152.49268, 10, 3.0);
				SetPVarInt(playerid, "traktorid", GetPlayerVehicleID(playerid));
				SetPVarInt(playerid, "trailerid", GetVehicleTrailer(GetPlayerVehicleID(playerid)));
				}


				if(GetPlayerVehicleID(playerid) == farm[4] && GetPVarInt(playerid, "zapoceo") || GetPlayerVehicleID(playerid) == farm[5] && GetPVarInt(playerid, "zapoceo") || GetPlayerVehicleID(playerid) == farm[6] && GetPVarInt(playerid, "zapoceo")){
				SendClientMessage(playerid, COLOR_YELLOW, "Idite do sijacice i ukucajte "STRING_WHITE"/spoji"STRING_YELLOW" da krenete sijati.");
				SetPVarInt(playerid, "traktorid", GetPlayerVehicleID(playerid));
				SetPVarInt(playerid, "trailerid", GetVehicleTrailer(GetPlayerVehicleID(playerid)));
				}
     }
     if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
     {
        TextDrawHideForPlayer(playerid, speedbar0);
				TextDrawHideForPlayer(playerid, speedbar1);
				TextDrawHideForPlayer(playerid, speedbar2);
				TextDrawHideForPlayer(playerid, speedbar3);
				TextDrawHideForPlayer(playerid, speedbar4);

				PlayerTextDrawHide(playerid, speedbar5[playerid]);
				PlayerTextDrawHide(playerid, speedbar6[playerid]);
				PlayerTextDrawHide(playerid, speedbar7[playerid]);
				PlayerTextDrawHide(playerid, speedbar8[playerid]);

        KillTimer(speedtimer[playerid]);
			  if(GetPVarInt(playerid, "zapoceo") == 1){
				SendClientMessage(playerid, COLOR_ADMWARN, "Izasli ste iz vozila te tako prekinuli posao.");
				SetPVarInt(playerid, "zapoceo", 0);
				SetVehicleToRespawn(GetPVarInt(playerid, "traktorid"));
				SetVehicleToRespawn(GetPVarInt(playerid, "trailerid"));
				}
     }
     return 1;
}
forward OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (GetPVarInt(playerid, "Gun") == 0)
	    {
     		new name[MAX_PLAYER_NAME];
     		GetPlayerName(playerid, name, sizeof(name));
     		new adminwarn1[72];
 		    format(adminwarn1,sizeof(adminwarn1),"ADMIN WARN: Kod igraca %s je detektiran hack: Weapon Hack",name);
    		SendToAdmins(ADMINWARN,adminwarn1);
    		Kick(playerid);
	    }
	return 1;
}
public speedometer(playerid)
{
    GetVehicleVelocity(GetPlayerVehicleID(playerid), svx[playerid], svy[playerid], svz[playerid]);
    o1[playerid] = floatsqroot(((svx[playerid]*svx[playerid])+(svy[playerid]*svy[playerid]))+(svz[playerid]*svz[playerid]))*100;
    o2[playerid] = floatround(o1[playerid],floatround_round);
    format(o3[playerid],256,"%i", o2[playerid]);
    PlayerTextDrawSetString(playerid, speedbar5[playerid], o3[playerid]);


		new Float:health;
		GetVehicleHealth(GetPlayerVehicleID(playerid), health);
		new rh[16];
		format(rh,sizeof(rh),"%i",floatround(health));
		PlayerTextDrawSetString(playerid, speedbar8[playerid],rh);
	return 1;
}
