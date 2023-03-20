#Real-time-howling-suppression
## Description: 
Basically, this app repo is a algorithm model **using matlab simulink**. It contains sevral methods to detect and suppress howling noise in real time.
* NHS - Notchfilter howling suppression
* SFM - Spectrum flatness method

You can choose your audio input(Audio Device Reader in simulink) and output (Audio Device Writer in simulink) and run the algorithm to achieve howling detection and howling suppression in real-time. The implementation is base on NHS(Notch filter howling suppressior).
***********
![image](https://user-images.githubusercontent.com/96840064/222073264-636363b1-f040-4d7e-8582-e089a947c147.png)

I also have another implementation base on SFM(Spectrum flatness measurement).
![image](https://user-images.githubusercontent.com/96840064/223676467-fde9a682-2266-4c1b-a8cd-f8af774a66a5.png)

*These 2 models are in Matlab 2022b version, you need to use this version to open. If you need other version, please contact me. zhouyiliang0311@163.com*
- - - - - - 
## Reference
-[1]: (Toon van Waterschoot, Marc Moonen) *Comparative evaluation of howling detection criteria in notch-filter-based howling suppression* November 2010, Published in Journal of the Audio Engineering Society, vol. 58, no. 11, Nov. 2010, pp. 923–940.

-[2]: (Jithin Ta, Mohamed Salih K Kb, Jayan A Rc) *Real Time Suppression of Howling Noise in Public Address System* International Conference on Emerging Trends in Engineering, Science and Technology (ICETEST - 2015) 
