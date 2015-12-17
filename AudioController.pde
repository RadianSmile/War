import ddf.minim.*;


class AudioController {

  Minim minim;
  AudioPlayer banana ;
  
  AudioController () {
    banana = minim.loadFile("audio/a.caf",2048);
  }

}