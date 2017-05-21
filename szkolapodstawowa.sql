-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Czas generowania: 21 Maj 2017, 11:43
-- Wersja serwera: 10.1.10-MariaDB
-- Wersja PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin2 */;

--
-- Baza danych: `szkolapodstawowa`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajsale` (IN `@numersali` CHAR(3), IN `@pesel` CHAR(11))  NO SQL
BEGIN

-- Sprawdzam pesel

IF((SELECT COUNT(PESEL) FROM nauczyciel WHERE PESEL = @pesel ) <> 0)
THEN
  IF((SELECT COUNT(NumerSali) FROM Sala WHERE NumerSali = @numersali) <> 0)
  THEN
  	INSERT INTO `sala` VALUES(@numersali,@pesel);
  END IF;
END IF;


END$$

--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `wyswietlzarobki` (`_pesel` CHAR(11) CHARSET utf8) RETURNS FLOAT NO SQL
BEGIN

DECLARE _zarobek FLOAT;

IF((SELECT count(PESEL) FROM nauczyciel WHERE PESEL=_pesel) = 0)
THEN
	RETURN -1;
END IF;

SET _zarobek = 0;

RETURN (SELECT Placa FROM nauczyciel WHERE PESEL=_pesel);


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `absolwent`
--

CREATE TABLE `absolwent` (
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci.Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `Srednia` float DEFAULT NULL COMMENT '''Atrybut srednia przedstawia z jak± ¶rednia dany uczeñ zakoñczy³ edukacjê.',
  `Imie` char(20) NOT NULL COMMENT '''Imiê (³ac. nomen) - osobista nazwa nadawana osobie przez grupê, do której nale¿y. Wraz z ewentualnym drugim i nastêpnymi imionami oraz z nazwiskiem, czasem patronimikiem (ros. ????????, trans. otcziestwo), a rzadziej przydomkiem, stanowi u wiêkszo¶ci ludów podstawowe okre¶lenie danej osoby.',
  `Nazwisko` char(30) NOT NULL COMMENT '''Nazwisko - nazwa rodziny, do której dana osoba nale¿y. Wraz z imieniem stanowi u wiêkszo¶ci ludów podstawê identyfikacji danej osoby.',
  `Plec` char(1) DEFAULT NULL COMMENT '''P³eæ - zespó³ cech o charakterze struktur i funkcji pozwalaj±cych na sklasyfikowanie organizmów na mêskie i ¿eñskie.',
  `DataUrodzenia` date DEFAULT NULL COMMENT '''Data urodzenia - w prawie i genealogii data przyj¶cia na ¶wiat (tj. zakoñczenia drugiego etapu porodu danej osoby), tj. dzieñ, miesi±c i rok w kalendarzu gregoriañskim. Obecnie jedynym prawnym dowodem i ¼ród³em daty urodzenia osoby jest jej akt urodzenia wystawiony przez w³a¶ciwy dla miejsca urodzenia urz±d stanu cywilnego.',
  `MiejsceUrodzenia` char(30) DEFAULT NULL COMMENT '''Miejsce urodzenia - odnotowana w akcie urodzenia (dokumencie wystawionym przez w³a¶ciwy urz±d stanu cywilnego) nazwa miejscowo¶ci, w której odby³ siê poród danej osoby.',
  `Telefon` char(9) DEFAULT NULL COMMENT '''Numer telefonu - ci±g cyfr identyfikuj±cych abonenta telefonicznego, których wybranie za pomoc± urz±dzeñ telekomunikacyjnych (telefon, telefaks, modem) powoduje zestawienie po³±czenia, przy wykorzystaniu publicznej sieci telefonicznej, z ¿±danym abonentem (któremu ten numer zosta³ przypisany przez operatora telekomunikacyjnego).',
  `Adres` char(30) DEFAULT NULL COMMENT '''Adres zameldowania (zameldowanie) - okre¶lenie miejscowo¶ci (miasta, wsi), ulicy (osiedla), numeru domu oraz ewentualnie numeru lokalu mieszkalnego, w którym na sta³e lub czasowo przebywa dana osoba.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='''Grupa uczniów która ukoñczy³a szko³ê podstawow± i s± jej absolwentami.';

-- --------------------------------------------------------

--
-- Zast±piona struktura widoku `czasnauki`
--
CREATE TABLE `czasnauki` (
`PESEL` char(11)
,`Imie` char(20)
,`Nazwisko` char(30)
,`IleSemestrow` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klasa`
--

CREATE TABLE `klasa` (
  `IDKlasy` char(5) NOT NULL COMMENT '''Grupa uczniów szko³y do 30 osób, na tym samym roku i tym samym toku nauczania. Wg. definicji klasa - pot. o grupie uczniów uczêszczaj±cych razem na wiêkszo¶æ zajêæ.',
  `PESEL` char(11) NOT NULL COMMENT '''Indywidualny klucz klasy. Sk³adaj±cy siê z nastêpuj±cych znaków: xxxxY XXXX - data rozpoczêcia nauki, YY - numer klasy wynikaj±cy z podzia³u wszystkich uczniów na podgrupy ( przyjmuje warto¶ci od A-Z ) Przyklad: 1993B',
  `RozszerzJezyk` smallint(6) NOT NULL COMMENT '''Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci.Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Grupa uczniów szko³y do 30 osób, na tym samym roku i tym samym toku nauczania. Wg. definicji klasa - pot. o grupie uczniów uczêszczaj±cych razem na wiêkszo¶æ zajêæ.';

--
-- Zrzut danych tabeli `klasa`
--

INSERT INTO `klasa` (`IDKlasy`, `PESEL`, `RozszerzJezyk`) VALUES
('2014A', '01091610352', 1),
('2014B', '18012318181', 0),
('2015A', '72082313468', 1),
('2015B', '54011912247', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lekcja`
--

CREATE TABLE `lekcja` (
  `IDLekcji` int(11) NOT NULL COMMENT '''45-minutowy blok czasu, po¶wiêcany na kszta³cenie uczniów z danego przedmiotu.',
  `IDSemestru` char(5) NOT NULL COMMENT '''ID Semestru jest to indywidualny klucz Semestr sk³adajacy sie z 5 znakow: xxY: xxxx - oznaczenie rocznika w którym wystêpowa³ semestr; Y - oznaczenie semestru ( L - letni, Z - zimowy ) ',
  `IDKlasy` char(5) NOT NULL COMMENT '''Indywidualny klucz klasy. Sk³adaj±cy siê z nastêpuj±cych znaków: xxxxY XXXX - data rozpoczêcia nauki, YY - numer klasy wynikaj±cy z podzia³u wszystkich uczniów na podgrupy ( przyjmuje warto¶ci od A-Z ) Przyklad: 1993B',
  `NumerSali` char(3) NOT NULL COMMENT '''NumerSali jest kluczem Sala a jednocze¶nie atrybutem okre¶laj±cym numer przyporz±dkowany sali w trakcie numeracji ich w budynku. Istnieje pewna zale¿no¶æ miêdzy numerem sali a poziomem w budynku na którym ona wystêpuje. I tak pierwsza cyfra = 0 -> sala znajduje siê na parterze, pierwsza cyfra = 1 -> sala znajduje siê na pierwszym piêtrze itd.',
  `IDPrzedmiotu` int(11) NOT NULL COMMENT '''Unikalny, jednoznaczny identyfikator tabeli Przedmiot''',
  `PESEL` char(11) NOT NULL COMMENT '''Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci.Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `DzieñTygodnia` char(20) DEFAULT NULL COMMENT '''Dzieñ w którym odbywa siê lekcja. Zakres: poniedzia³ek - sobota',
  `NumerBlokuLekcji` int(11) DEFAULT NULL COMMENT '''Numer bloku na którym w danym dniu odbywaj± siê zajêcia. Jeden blok trwa 45 min, pomiêdzy blokami wystêpuje 10  minutowa przerwa a numerowanie bloków zaczyna siê po starcie zajêæ o godzinie 8 rano.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='45-minutowy blok czasu, po¶wiêcany na kszta³cenie uczniów z danego przedmiotu.';

--
-- Zrzut danych tabeli `lekcja`
--

INSERT INTO `lekcja` (`IDLekcji`, `IDSemestru`, `IDKlasy`, `NumerSali`, `IDPrzedmiotu`, `PESEL`, `DzieñTygodnia`, `NumerBlokuLekcji`) VALUES
(1, '2015L', '2015B', '017', 1, '54011912247', 'Poniedzialek', 2),
(2, '2015L', '2015B', '017', 2, '72082313468', 'Poniedzialek', 1),
(3, '2015L', '2015B', '221', 3, '18012318181', 'Wtorek', 2),
(4, '2015L', '2015B', '017', 4, '01091610352', 'Wtorek', 1),
(5, '2015L', '2015A', '221', 5, '54011912247', 'Sroda', 1),
(6, '2015L', '2015A', '017', 6, '72082313468', 'Czwartek', 2),
(7, '2015L', '2014A', '321', 7, '01091610352', 'Piatek', 1),
(8, '2015L', '2015A', '017', 1, '01091610352', 'Piatek', 1),
(9, '2015L', '2015A', '321', 2, '54011912247', 'Piatek', 2),
(10, '2015L', '2015B', '018', 3, '72082313468', 'Piatek', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `nauczyciel`
--

CREATE TABLE `nauczyciel` (
  `PESEL` char(11) NOT NULL COMMENT '''Numer bloku na którym w danym dniu odbywaj± siê zajêcia. Jeden blok trwa 45 min, pomiêdzy blokami wystêpuje 10  minutowa przerwa a numerowanie bloków zaczyna siê po starcie zajêæ o godzinie 8 rano.',
  `IDKlasy` char(5) DEFAULT NULL COMMENT '''Indywidualny klucz klasy. Sk³adaj±cy siê z nastêpuj±cych znaków: xxxxY XXXX - data rozpoczêcia nauki, YY - numer klasy wynikaj±cy z podzia³u wszystkich uczniów na podgrupy ( przyjmuje warto¶ci od A-Z ) Przyklad: 1993B',
  `NumerSali` char(3) DEFAULT NULL COMMENT '''NumerSali jest kluczem Sala a jednocze¶nie atrybutem okre¶laj±cym numer przyporz±dkowany sali w trakcie numeracji ich w budynku. Istnieje pewna zale¿no¶æ miêdzy numerem sali a poziomem w budynku na którym ona wystêpuje. I tak pierwsza cyfra = 0 -> sala znajduje siê na parterze, pierwsza cyfra = 1 -> sala znajduje siê na pierwszym piêtrze itd.',
  `Imie` char(20) NOT NULL COMMENT '''Imiê (³ac. nomen) - osobista nazwa nadawana osobie przez grupê, do której nale¿y. Wraz z ewentualnym drugim i nastêpnymi imionami oraz z nazwiskiem, czasem patronimikiem (ros. ????????, trans. otcziestwo), a rzadziej przydomkiem, stanowi u wiêkszo¶ci ludów podstawowe okre¶lenie danej osoby.',
  `Nazwisko` char(30) NOT NULL COMMENT '''Nazwisko - nazwa rodziny, do której dana osoba nale¿y. Wraz z imieniem stanowi u wiêkszo¶ci ludów podstawê identyfikacji danej osoby.',
  `Plec` char(1) DEFAULT NULL COMMENT '''P³eæ - zespó³ cech o charakterze struktur i funkcji pozwalaj±cych na sklasyfikowanie organizmów na mêskie i ¿eñskie.',
  `DataUrodzenia` date DEFAULT NULL COMMENT '''Data urodzenia - w prawie i genealogii data przyj¶cia na ¶wiat (tj. zakoñczenia drugiego etapu porodu danej osoby), tj. dzieñ, miesi±c i rok w kalendarzu gregoriañskim. Obecnie jedynym prawnym dowodem i ¼ród³em daty urodzenia osoby jest jej akt urodzenia wystawiony przez w³a¶ciwy dla miejsca urodzenia urz±d stanu cywilnego.',
  `MiejsceUrodzenia` char(30) DEFAULT NULL COMMENT '''Miejsce urodzenia - odnotowana w akcie urodzenia (dokumencie wystawionym przez w³a¶ciwy urz±d stanu cywilnego) nazwa miejscowo¶ci, w której odby³ siê poród danej osoby.',
  `Telefon` char(9) DEFAULT NULL COMMENT '''Numer telefonu - ci±g cyfr identyfikuj±cych abonenta telefonicznego, których wybranie za pomoc± urz±dzeñ telekomunikacyjnych (telefon, telefaks, modem) powoduje zestawienie po³±czenia, przy wykorzystaniu publicznej sieci telefonicznej, z ¿±danym abonentem (któremu ten numer zosta³ przypisany przez operatora telekomunikacyjnego).',
  `Adres` char(30) DEFAULT NULL COMMENT '''Adres zameldowania (zameldowanie) - okre¶lenie miejscowo¶ci (miasta, wsi), ulicy (osiedla), numeru domu oraz ewentualnie numeru lokalu mieszkalnego, w którym na sta³e lub czasowo przebywa dana osoba.',
  `DataZatrudnienia` date NOT NULL COMMENT '''Data w której pracodawca ( dyrektor szko³y ) przyj±³ to pracy nauczyciela.',
  `Placa` int(11) DEFAULT NULL COMMENT '''Ca³kowite miesiêczne wynagrodzenie otrzymywane przez nauczyciela ( brutto )'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Osoba zatrudniona przez szko³ê do nauki uczniów konkretnych przedmiotów.';

--
-- Zrzut danych tabeli `nauczyciel`
--

INSERT INTO `nauczyciel` (`PESEL`, `IDKlasy`, `NumerSali`, `Imie`, `Nazwisko`, `Plec`, `DataUrodzenia`, `MiejsceUrodzenia`, `Telefon`, `Adres`, `DataZatrudnienia`, `Placa`) VALUES
('01091610352', '018', '201', 'Wladyslaw', 'Zenek', 'M', NULL, 'Zamosc', '671671111', 'Jaroslawice 31', '2004-01-20', 2100),
('18012318181', '321', '201', 'Justyna', 'Miroslawka', 'K', NULL, 'Maciejowiczki', '817364222', 'Warszawa ul. Kaliskiego 12', '1999-12-19', 2500),
('54011912247', '017', '201', 'Anna', 'Kovaliv', 'K', NULL, 'Jaroslawice', '512683432', 'Malkowice 117', '2001-01-20', 3000),
('72082313468', '221', '201', 'Marzena', 'Mroczek', 'K', NULL, 'Ostrów Wlkp', '511227342', 'Zurawica 92', '1998-03-01', 2000);

--
-- Wyzwalacze `nauczyciel`
--
DELIMITER $$
CREATE TRIGGER `sprpesel` BEFORE INSERT ON `nauczyciel` FOR EACH ROW BEGIN
	DECLARE _pesel CHAR(11);
    DECLARE _ilosc INTEGER;
    DECLARE _sum INTEGER; 

SET _pesel = (NEW.PESEL);
 SET _ilosc = 1*SUBSTRING(_pesel,1,1);
    SET _sum = _ilosc;

    SET _ilosc = 3*SUBSTRING(_pesel,2,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 7*SUBSTRING(_pesel,3,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 9*SUBSTRING(_pesel,4,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 1*SUBSTRING(_pesel,5,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 3*SUBSTRING(_pesel,6,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 7*SUBSTRING(_pesel,7,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 9*SUBSTRING(_pesel,8,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 1*SUBSTRING(_pesel,9,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 3*SUBSTRING(_pesel,10,1);
    SET _sum = _sum + _ilosc;

    SET _ilosc = 1*SUBSTRING(_pesel,11,1);
    SET _sum = _sum + _ilosc;

    SET _sum = mod(_sum,10);
    
    IF _sum <> 0
    THEN 
    delete from nauczyciel where PESEL=new.PESEL;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ocena`
--

CREATE TABLE `ocena` (
  `IDOceny` int(11) NOT NULL COMMENT 'Unikalny, jednoznaczny identyfikator tabeli Przedmiot''',
  `IDPrzedmiotu` int(11) NOT NULL COMMENT '''Unikalny, jednoznaczny identyfikator tabeli Przedmiot',
  `IDSemestru` char(5) NOT NULL COMMENT 'ID Semestru jest to indywidualny klucz Semestr sk³adaj±cy siê z 5 znaków: xxxxY: xxxx - oznaczenie rocznika w którym wystêpowa³ semestr; Y - oznaczenie semestru ( L - letni, Z - zimowy ) ',
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `Nau_PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `Wartosc` decimal(2,1) NOT NULL COMMENT 'Warto¶æ wystawionej oceny. Przyjmuje siê skalê: 1 1+ 2- 2 2+ 3- 3 3+ 4- 4 4+ 5- 5 5+ 6',
  `DataWystawienia` date DEFAULT NULL COMMENT 'Data wystawienia oceny uczniowi.',
  `Rodzaj` char(1) NOT NULL COMMENT 'Rodzaj oceny. S - sprawdzian, U - odpowied¼ ustna, K - "kartkówka", P - projekt, Z - zadanie domowe. Na podstawie rodzaju oceny mo¿na okre¶liæ konkretne wagi.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='''Cyfra, wystawiana przez nauczyciela i okre¶laj±ca stopieñ przyswojenia wiedzy przez ucznia.';

--
-- Zrzut danych tabeli `ocena`
--

INSERT INTO `ocena` (`IDOceny`, `IDPrzedmiotu`, `IDSemestru`, `PESEL`, `Nau_PESEL`, `Wartosc`, `DataWystawienia`, `Rodzaj`) VALUES
(1, 1, '2015L', '15221212710', '54011912247', '4.5', '2015-05-04', 'U'),
(2, 1, '2015L', '01251418495', '54011912247', '3.5', '2015-04-14', 'U'),
(3, 1, '2015L', '06232412613', '54011912247', '5.0', '2015-04-12', 'U'),
(4, 1, '2015L', '98030915117', '54011912247', '4.0', '2015-04-12', 'U'),
(5, 1, '2015L', '07262309351', '54011912247', '3.0', '2015-05-19', 'Z'),
(6, 1, '2015L', '15221212710', '54011912247', '2.0', '2015-05-18', 'U'),
(7, 1, '2015L', '01251418495', '54011912247', '1.0', '2015-05-17', 'S'),
(8, 1, '2015L', '06232412613', '54011912247', '1.0', '2015-05-16', 'U'),
(9, 1, '2015L', '98030915117', '54011912247', '2.0', '2015-04-15', 'Z'),
(10, 2, '2015L', '15221212710', '72082313468', '3.0', '2015-05-15', 'S'),
(11, 2, '2015L', '01251418495', '72082313468', '4.0', '2015-04-12', 'U'),
(12, 2, '2015L', '06232412613', '72082313468', '5.0', '2015-05-14', 'Z'),
(13, 2, '2015L', '98030915117', '72082313468', '6.0', '2015-05-15', 'S'),
(14, 2, '2015L', '15221212710', '72082313468', '2.0', '2015-05-27', 'U'),
(15, 2, '2015Z', '01251418495', '72082313468', '4.0', '2015-02-17', 'Z'),
(16, 2, '2015Z', '06232412613', '72082313468', '5.0', '2015-02-01', 'S'),
(17, 2, '2015Z', '98030915117', '72082313468', '6.0', '2015-02-06', 'U'),
(18, 2, '2015Z', '98030915117', '72082313468', '1.0', '2015-01-21', 'S'),
(19, 3, '2015Z', '15221212710', '18012318181', '1.0', '2015-01-05', 'U'),
(20, 3, '2015Z', '01251418495', '18012318181', '1.0', '2015-02-01', 'Z'),
(21, 3, '2015Z', '06232412613', '18012318181', '1.0', '2015-01-24', 'S'),
(22, 3, '2015Z', '98030915117', '18012318181', '2.0', '2015-01-01', 'U'),
(23, 3, '2015Z', '98030915117', '18012318181', '4.0', '2015-02-01', 'Z'),
(24, 6, '2015Z', '15221212710', '01091610352', '5.0', '2015-01-05', 'U'),
(25, 6, '2015Z', '01251418495', '01091610352', '6.0', '2015-05-05', 'S'),
(26, 6, '2014L', '06232412613', '01091610352', '6.0', '2014-04-01', 'Z'),
(27, 4, '2014L', '98030915117', '01091610352', '4.0', '2014-04-02', 'U'),
(28, 4, '2014L', '06232412613', '01091610352', '2.0', '2014-04-02', 'Z'),
(29, 4, '2014L', '15221212710', '01091610352', '1.0', '2014-04-02', 'U'),
(30, 5, '2014L', '01251418495', '01091610352', '2.0', '2014-04-02', 'U'),
(31, 1, '2015L', '06232412613', '54011912247', '1.0', '2015-05-16', 'U'),
(32, 2, '2015L', '98030915117', '54011912247', '2.0', '2015-04-15', 'Z'),
(33, 3, '2015L', '15221212710', '72082313468', '3.0', '2015-05-15', 'S'),
(34, 4, '2015L', '01251418495', '72082313468', '4.0', '2015-04-12', 'U'),
(35, 5, '2015L', '06232412613', '72082313468', '5.0', '2015-05-14', 'Z'),
(36, 6, '2015L', '98030915117', '72082313468', '6.0', '2015-05-15', 'S'),
(37, 7, '2015L', '15221212710', '72082313468', '2.0', '2015-05-27', 'U'),
(38, 8, '2015Z', '98030915117', '18012318181', '4.0', '2015-02-01', 'Z'),
(39, 9, '2014L', '06232412613', '01091610352', '2.0', '2014-04-02', 'Z');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `podzialgodzin`
--

CREATE TABLE `podzialgodzin` (
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `IDPrzedmiotu` int(11) NOT NULL COMMENT 'Unikalny, jednoznaczny identyfikator tabeli Przedmiot',
  `IDSemestru` char(5) NOT NULL COMMENT 'ID Semestru jest to indywidualny klucz Semestr sk³adaj±cy siê z 5 znaków: xxxxY: xxxx - oznaczenie rocznika w którym wystêpowa³ semestr; Y - oznaczenie semestru ( L - letni, Z - zimowy ) ',
  `LiczbaGodzin` int(11) DEFAULT NULL COMMENT 'Przewidziany semestralny zakres godzinowy danego przedmiotu prowadzonego przez konkretnego nauczyciela.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='''Okre¶la ilo¶æ godzin konkretnego przedmiotu na konkretny semestr.';

--
-- Zrzut danych tabeli `podzialgodzin`
--

INSERT INTO `podzialgodzin` (`PESEL`, `IDPrzedmiotu`, `IDSemestru`, `LiczbaGodzin`) VALUES
('01091610352', 6, '2015Z', 45),
('01091610352', 7, '2015Z', 65),
('18012318181', 2, '2015L', 35),
('18012318181', 3, '2015L', 43),
('18012318181', 4, '2015L', 12),
('18012318181', 5, '2015L', 32),
('54011912247', 1, '2015L', 43),
('54011912247', 3, '2015L', 23),
('54011912247', 5, '2015L', 53),
('54011912247', 7, '2015L', 45),
('72082313468', 1, '2015L', 32),
('72082313468', 2, '2015L', 45),
('72082313468', 4, '2015L', 45),
('72082313468', 6, '2015L', 21);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przedmiot`
--

CREATE TABLE `przedmiot` (
  `IDPrzedmiotu` int(11) NOT NULL COMMENT 'Unikalny, jednoznaczny identyfikator tabeli Przedmiot',
  `NazwaPrzedmiotu` char(20) NOT NULL COMMENT 'Nazwa okre¶laj±ca nauczany przedmiot, który realizuje siê wg. podstawy programowej.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Dziedzina nauki, której dotyczy zbiór zajêæ prowadzonych przez konkretnego nauczyciela.';

--
-- Zrzut danych tabeli `przedmiot`
--

INSERT INTO `przedmiot` (`IDPrzedmiotu`, `NazwaPrzedmiotu`) VALUES
(1, 'Historia'),
(2, 'J?zyk polski'),
(3, 'J?zyk obcy'),
(4, 'Matematyka'),
(5, 'Przyroda'),
(6, 'Muzyka'),
(7, 'Plastyka');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzic`
--

CREATE TABLE `rodzic` (
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `JestRada` smallint(6) DEFAULT NULL COMMENT 'Atrybut JestRada jest atrybutem binarnym okre¶laj±cym fakt czy rodzic jest w radzie rodziców,',
  `Imie` char(20) NOT NULL COMMENT 'Imiê (³ac. nomen) - osobista nazwa nadawana osobie przez grupê, do której nale¿y. Wraz z ewentualnym drugim i nastêpnymi imionami oraz z nazwiskiem, czasem patronimikiem (ros. ????????, trans. otcziestwo), a rzadziej przydomkiem, stanowi u wiêkszo¶ci ludów podstawowe okre¶lenie danej osoby.',
  `Nazwisko` char(30) NOT NULL COMMENT 'Nazwisko - nazwa rodziny, do której dana osoba nale¿y. Wraz z imieniem stanowi u wiêkszo¶ci ludów podstawê identyfikacji danej osoby.',
  `Plec` char(1) DEFAULT NULL COMMENT 'P³eæ - zespó³ cech o charakterze struktur i funkcji pozwalaj±cych na sklasyfikowanie organizmów na mêskie i ¿eñskie.',
  `DataUrodzenia` date DEFAULT NULL COMMENT 'Data urodzenia - w prawie i genealogii data przyj¶cia na ¶wiat (tj. zakoñczenia drugiego etapu porodu danej osoby), tj. dzieñ, miesi±c i rok w kalendarzu gregoriañskim. Obecnie jedynym prawnym dowodem i ¼ród³em daty urodzenia osoby jest jej akt urodzenia wystawiony przez w³a¶ciwy dla miejsca urodzenia urz±d stanu cywilnego.',
  `MiejsceUrodzenia` char(30) DEFAULT NULL COMMENT 'przez w³a¶ciwy urz±d stanu cywilnego) nazwa miejscowo¶ci, w której odby³ siê poród danej osoby.',
  `Telefon` char(9) DEFAULT NULL COMMENT 'Numer telefonu - ci±g cyfr identyfikuj±cych abonenta telefonicznego, których wybranie za pomoc± urz±dzeñ telekomunikacyjnych (telefon, telefaks, modem) powoduje zestawienie po³±czenia, przy wykorzystaniu publicznej sieci telefonicznej, z ¿±danym abonentem (któremu ten numer zosta³ przypisany przez operatora telekomunikacyjnego).',
  `Adres` char(30) DEFAULT NULL COMMENT 'Adres zameldowania (zameldowanie) - okre¶lenie miejscowo¶ci (miasta, wsi), ulicy (osiedla), numeru domu oraz ewentualnie numeru lokalu mieszkalnego, w którym na sta³e lub czasowo przebywa dana osoba.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Opiekun prawny ucznia. Rodzic jest po¶rednio odpowiedzialny za proces nauczania dziecka.';

--
-- Zrzut danych tabeli `rodzic`
--

INSERT INTO `rodzic` (`PESEL`, `JestRada`, `Imie`, `Nazwisko`, `Plec`, `DataUrodzenia`, `MiejsceUrodzenia`, `Telefon`, `Adres`) VALUES
('49071307102', 1, 'Martyna', 'Tredewicz', 'K', NULL, 'Gliwice', '625346728', 'Gutowiec 17'),
('81072304450', 0, 'Lukasz', 'Tulin', 'M', NULL, 'Katowice', '566543234', 'Z?otowo 43'),
('88083105302', 0, 'Anna', 'Kryger', 'K', NULL, 'Zle Mieso', '654283498', 'Gutowiec 23'),
('95872401462', 0, 'Wiktoria', 'Rutkowski', 'K', NULL, 'Tczew', '567345928', 'Z?otowo 12'),
('96821203555', 1, 'Marcin', 'Tylman', 'M', NULL, 'Elbl?g', '548923476', 'Rokitki 12');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sala`
--

CREATE TABLE `sala` (
  `NumerSali` char(3) NOT NULL COMMENT 'NumerSali jest kluczem Sala a jednocze¶nie atrybutem okre¶laj±cym numer przyporz±dkowany sali w trakcie numeracji ich w budynku. Istnieje pewna zale¿no¶æ miêdzy numerem sali a poziomem w budynku na którym ona wystêpuje. I tak pierwsza cyfra = 0 -> sala znajduje siê na parterze, pierwsza cyfra = 1 -> sala znajduje siê na pierwszym piêtrze itd.',
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Pomieszczenie, w którym odbywaj± siê lekcje. Sala znajduje siê w budynku szko³y.';

--
-- Zrzut danych tabeli `sala`
--

INSERT INTO `sala` (`NumerSali`, `PESEL`) VALUES
('017', '54011912247'),
('018', '01091610352'),
('221', '72082313468'),
('321', '18012318181');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `semestr`
--

CREATE TABLE `semestr` (
  `IDSemestru` char(5) NOT NULL COMMENT 'ID Semestru jest to indywidualny klucz Semestr sk³adaj±cy siê z 5 znaków: xxxxY: xxxx - oznaczenie rocznika w którym wystêpowa³ semestr; Y - oznaczenie semestru ( L - letni, Z - zimowy ) ',
  `NazwaSemestru` char(30) DEFAULT NULL COMMENT 'Nazwa semestru, kolejno - Letni, Zimowy.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Czas od 1 wrze¶nia do ferii zimowych, lub od ferii zimowych do 31 czerwca, w którym uczniowie zbieraj± oceny.';

--
-- Zrzut danych tabeli `semestr`
--

INSERT INTO `semestr` (`IDSemestru`, `NazwaSemestru`) VALUES
('2014L', 'Letni'),
('2014Z', 'Zimowy'),
('2015L', 'Letni'),
('2015Z', 'Zimowy');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sprzet`
--

CREATE TABLE `sprzet` (
  `IDSprzetu` char(3) NOT NULL COMMENT 'Indywidualny klucz sprzêtu. Numer seryjny produktu.',
  `NumerSali` char(3) DEFAULT NULL COMMENT 'NumerSali jest kluczem Sala a jednocze¶nie atrybutem okre¶laj±cym numer przyporz±dkowany sali w trakcie numeracji ich w budynku. Istnieje pewna zale¿no¶æ miêdzy numerem sali a poziomem w budynku na którym ona wystêpuje. I tak pierwsza cyfra = 0 -> sala znajduje siê na parterze, pierwsza cyfra = 1 -> sala znajduje siê na pierwszym piêtrze itd.',
  `Nazwa` char(20) NOT NULL COMMENT 'Nazwa u¿ywanego sprzêtu.',
  `Typ` char(20) NOT NULL COMMENT 'Typ u¿ywanego sprzêtu, Okre¶la czym jest dany sprzêt.',
  `Uzywany` int(11) DEFAULT NULL COMMENT 'Atrybut okre¶la ile razy sprzêt zosta³ u¿yty.',
  `DataZakupu` date DEFAULT NULL COMMENT 'Atrybut okre¶la kiedy dany sprzêt zosta³ zakupiony.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Sprzêt przechowuje informacje o wszelkim sprzêcie wykorzystywanym w szkole.';

--
-- Zrzut danych tabeli `sprzet`
--

INSERT INTO `sprzet` (`IDSprzetu`, `NumerSali`, `Nazwa`, `Typ`, `Uzywany`, `DataZakupu`) VALUES
('09s', '221', 'Lenovo', 'Komputer stacjonarny', 123, '2014-01-02'),
('A21', '017', 'Samsung', 'Laptop', 123, '2013-04-21'),
('AsD', '221', 'Lenovo', 'Laptop', 452, '2001-01-24'),
('C99', '017', 'LG', 'Rzutnik', 321, '2014-01-24'),
('ELO', '221', 'Lenovo', 'Komputer stacjonarny', 123, '2014-01-02'),
('Kk1', '321', 'Samsung', 'Telewizor', 145, '2013-04-17'),
('Kk2', '321', 'LG', 'Rzutnik', 155, '2014-04-20'),
('L11', '017', 'Lenovo', 'Telewizor', 321, '2014-01-14'),
('Nan', '221', 'Lenovo', 'Komputer stacjonarny', 123, '2014-01-02'),
('poW', '221', 'Lenovo', 'Komputer stacjonarny', 123, '2014-01-02'),
('R12', '321', 'Lenovo', 'Komputer stacjonarny', 334, '2014-04-20'),
('Wg1', '221', 'LG', 'Rzutnik', 421, '2013-04-23');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uczeñ`
--

CREATE TABLE `uczeñ` (
  `PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `IDKlasy` char(5) NOT NULL COMMENT 'Indywidualny klucz klasy. Sk³adaj±cy siê z nastêpuj±cych znaków: xxxxY XXXX - data rozpoczêcia nauki, YY - numer klasy wynikaj±cy z podzia³u wszystkich uczniów na podgrupy ( przyjmuje warto¶ci od A-Z ) Przyklad: 1993B',
  `Rod_PESEL` char(11) NOT NULL COMMENT 'Powszechny Elektroniczny System Ewidencji Ludno¶ci (PESEL) - centralny zbiór danych prowadzony w Polsce przez ministra w³a¶ciwego do spraw informatyzacji (do koñca 2015 r. przez ministra w³a¶ciwego do spraw wewnêtrznych) na mocy ustawy o ewidencji ludno¶ci. Rejestr s³u¿y do gromadzenia podstawowych informacji identyfikuj±cych to¿samo¶æ i status administracyjno-prawny obywateli polskich oraz cudzoziemców zamieszkuj±cych na terenie Rzeczypospolitej Polskiej. Mianem PESEL okre¶la siê równie¿ numer ewidencyjny osoby fizycznej wykorzystywany w tym rejestrze.',
  `Imie` char(20) NOT NULL COMMENT 'Imiê (³ac. nomen) - osobista nazwa nadawana osobie przez grupê, do której nale¿y. Wraz z ewentualnym drugim i nastêpnymi imionami oraz z nazwiskiem, czasem patronimikiem (ros. ????????, trans. otcziestwo), a rzadziej przydomkiem, stanowi u wiêkszo¶ci ludów podstawowe okre¶lenie danej osoby.',
  `Nazwisko` char(30) NOT NULL COMMENT 'Nazwisko - nazwa rodziny, do której dana osoba nale¿y. Wraz z imieniem stanowi u wiêkszo¶ci ludów podstawê identyfikacji danej osoby.',
  `Plec` char(1) DEFAULT NULL COMMENT 'P³eæ - zespó³ cech o charakterze struktur i funkcji pozwalaj±cych na sklasyfikowanie organizmów na mêskie i ¿eñskie.',
  `DataUrodzenia` date DEFAULT NULL COMMENT 'Data urodzenia - w prawie i genealogii data przyj¶cia na ¶wiat (tj. zakoñczenia drugiego etapu porodu danej osoby), tj. dzieñ, miesi±c i rok w kalendarzu gregoriañskim. Obecnie jedynym prawnym dowodem i ¼ród³em daty urodzenia osoby jest jej akt urodzenia wystawiony przez w³a¶ciwy dla miejsca urodzenia urz±d stanu cywilnego.',
  `MiejsceUrodzenia` char(30) DEFAULT NULL COMMENT 'Miejsce urodzenia - odnotowana w akcie urodzenia (dokumencie wystawionym przez w³a¶ciwy urz±d stanu cywilnego) nazwa miejscowo¶ci, w której odby³ siê poród danej osoby.',
  `Telefon` char(9) DEFAULT NULL COMMENT 'Numer telefonu - ci±g cyfr identyfikuj±cych abonenta telefonicznego, których wybranie za pomoc± urz±dzeñ telekomunikacyjnych (telefon, telefaks, modem) powoduje zestawienie po³±czenia, przy wykorzystaniu publicznej sieci telefonicznej, z ¿±danym abonentem (któremu ten numer zosta³ przypisany przez operatora telekomunikacyjnego).',
  `Adres` char(30) DEFAULT NULL COMMENT 'Adres zameldowania (zameldowanie) - okre¶lenie miejscowo¶ci (miasta, wsi), ulicy (osiedla), numeru domu oraz ewentualnie numeru lokalu mieszkalnego, w którym na sta³e lub czasowo przebywa dana osoba.',
  `Doje¿d¿a` smallint(6) DEFAULT NULL COMMENT 'Atrybut binarny okre¶laj±cy czy uczeñ doje¿d¿a z miejscowo¶ci innej ni¿ ta w której znajduje siê szko³a.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `uczeñ`
--

INSERT INTO `uczeñ` (`PESEL`, `IDKlasy`, `Rod_PESEL`, `Imie`, `Nazwisko`, `Plec`, `DataUrodzenia`, `MiejsceUrodzenia`, `Telefon`, `Adres`, `Doje¿d¿a`) VALUES
('01251418495', '2014B', '88083105302', 'Adam', 'Kryger', 'M', NULL, 'Gutowiec', '511231455', 'Gutowiec 23', 0),
('06232412613', '2015A', '95872401462', 'Tomek', 'Rutkowski', 'M', NULL, 'Gutowiec', '513234234', 'Zlotowo 12', 1),
('07262309351', '2014A', '81072304450', 'Adrian', 'Tulin', 'M', NULL, 'Wroclaw', '545213326', 'Zlotowo 43', 1),
('15221212710', '2014A', '49071307102', 'Eugeniusz', 'Tredewicz', 'M', NULL, 'Gutowiec', '542123456', 'Gutowiec 17', 0),
('98030915117', '2015B', '96821203555', 'Pawel', 'Tylman', 'M', NULL, 'Gutowiec', '514532843', 'Rokitki 12', 1);

-- --------------------------------------------------------

--
-- Struktura widoku `czasnauki`
--
DROP TABLE IF EXISTS `czasnauki`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `czasnauki`  AS  select `u`.`PESEL` AS `PESEL`,`u`.`Imie` AS `Imie`,`u`.`Nazwisko` AS `Nazwisko`,count(distinct `s`.`IDSemestru`) AS `IleSemestrow` from (((`uczeñ` `u` join `klasa` `k` on((`u`.`IDKlasy` = `k`.`IDKlasy`))) join `ocena` `o` on((`u`.`PESEL` = `o`.`PESEL`))) join `semestr` `s` on((`o`.`IDSemestru` = `s`.`IDSemestru`))) group by `u`.`PESEL`,`u`.`Imie`,`u`.`Nazwisko` order by `u`.`PESEL` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `absolwent`
--
ALTER TABLE `absolwent`
  ADD PRIMARY KEY (`PESEL`),
  ADD UNIQUE KEY `Absolwent_PK` (`PESEL`);

--
-- Indexes for table `klasa`
--
ALTER TABLE `klasa`
  ADD PRIMARY KEY (`IDKlasy`),
  ADD UNIQUE KEY `Klasa_PK` (`IDKlasy`);

--
-- Indexes for table `lekcja`
--
ALTER TABLE `lekcja`
  ADD PRIMARY KEY (`IDLekcji`),
  ADD UNIQUE KEY `Lekcja_PK` (`IDLekcji`);

--
-- Indexes for table `nauczyciel`
--
ALTER TABLE `nauczyciel`
  ADD PRIMARY KEY (`PESEL`),
  ADD UNIQUE KEY `Nauczyciel_PK` (`PESEL`);

--
-- Indexes for table `ocena`
--
ALTER TABLE `ocena`
  ADD PRIMARY KEY (`IDOceny`),
  ADD UNIQUE KEY `Ocena_PK` (`IDOceny`);

--
-- Indexes for table `podzialgodzin`
--
ALTER TABLE `podzialgodzin`
  ADD PRIMARY KEY (`PESEL`,`IDPrzedmiotu`,`IDSemestru`),
  ADD UNIQUE KEY `PodzialGodzin_PK` (`PESEL`,`IDPrzedmiotu`,`IDSemestru`);

--
-- Indexes for table `przedmiot`
--
ALTER TABLE `przedmiot`
  ADD PRIMARY KEY (`IDPrzedmiotu`),
  ADD UNIQUE KEY `Przedmiot_PK` (`IDPrzedmiotu`);

--
-- Indexes for table `rodzic`
--
ALTER TABLE `rodzic`
  ADD PRIMARY KEY (`PESEL`),
  ADD UNIQUE KEY `Rodzic_PK` (`PESEL`);

--
-- Indexes for table `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`NumerSali`),
  ADD UNIQUE KEY `Sala_PK` (`NumerSali`);

--
-- Indexes for table `semestr`
--
ALTER TABLE `semestr`
  ADD PRIMARY KEY (`IDSemestru`);

--
-- Indexes for table `sprzet`
--
ALTER TABLE `sprzet`
  ADD PRIMARY KEY (`IDSprzetu`),
  ADD UNIQUE KEY `Sprzet_PK` (`IDSprzetu`);

--
-- Indexes for table `uczeñ`
--
ALTER TABLE `uczeñ`
  ADD PRIMARY KEY (`PESEL`),
  ADD UNIQUE KEY `Uczeñ_PK` (`PESEL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
