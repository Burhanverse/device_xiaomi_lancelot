#include <src/piex.h>

using namespace piex;

extern "C" {

Error _ZN4piex19GetPreviewImageDataEPNS_15StreamInterfaceEPNS_16PreviewImageDataE(StreamInterface* data, PreviewImageData* preview_image_data) {
    return GetPreviewImageData(data, preview_image_data, nullptr);
}

}