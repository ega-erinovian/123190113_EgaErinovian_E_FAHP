namaGames = {'Game_1' 'Game_2' 'Game_3' 'Game_4'};
data = [ 2500 3000 2000
         2000 2500 900
         1500 1600 3000
         3000 4000 1000];

maksJumlahPemain = 3000;
maksJumlahDownload = 4000;
maksPemasukan = 3500;

data(:,1) = data(:,1) / maksJumlahPemain;
data(:,2) = data(:,2) / maksJumlahDownload;
data(:,3) = data(:,3) / maksPemasukan;

relasiAntarKriteria = [ 1     2     2
                        0     1     4
                        0     0     1];
                    
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);
                    
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Game | Skor Akhir | Kesimpulan')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Stop Pengembangan';
        elseif ahp(i) < 0.7
            status = 'Tingkatkan Pengambangan';
            elseif ahp(i) < 0.8
            status = 'Tambah DLC/Item Baru';
        else
            status = 'Maintain Pengembangan';
        end
        
        disp([char(namaGames(i)), blanks(13 - cellfun('length',namaGames(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
end