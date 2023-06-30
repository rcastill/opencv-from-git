use std::error::Error;

use opencv::{
    highgui::{imshow, wait_key},
    prelude::Mat,
    videoio::{VideoCapture, VideoCaptureTrait, VideoCaptureTraitConst, CAP_ANY},
};

fn main() -> Result<(), Box<dyn Error>> {
    let mut cap = VideoCapture::from_file("./test.mp4", CAP_ANY)?;
    if !cap.is_opened()? {
        eprintln!("cap closed");
        return Ok(());
    }
    loop {
        let mut im = Mat::default();
        if !cap.read(&mut im)? {
            eprintln!("read: false");
            break;
        }
        imshow("test.mp4", &im)?;

        // Pressed ESC
        if wait_key(1)? == 27 {
            break;
        }
    }
    Ok(())
}
