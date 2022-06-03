#include "direct_mapped_cache.h"
#include "cache_utilities.h"

#include <string>
#include <fstream>
#include <vector>
#include <bitset>
#include <iomanip>

using namespace std;

float direct_mapped(string filename, int block_size, int cache_size) {

    constexpr int ADDRESS_SIZE = 32;

    int total_num = 0;
    int hit_num = 0;

    int number_blocks = cache_size / block_size;

    int block_offset_size = get_indexing_size(block_size);
    int index_size = get_indexing_size(number_blocks);
    int tag_size = ADDRESS_SIZE - block_offset_size - index_size;

    int index_offset = block_offset_size;
    int tag_offset = index_offset + index_size;

    vector<Block> cache(number_blocks);

    ifstream file{ filename };

    uint32_t address;
    while (file >> hex >> address) {
        auto index = get_bits(address, index_offset, index_size);
        auto tag = get_bits(address, tag_offset, tag_size);

        Block& block = cache[index];

        if (not block.is_valid or block.tag != tag) { // currently not used or used by others
            block.tag = tag;
            block.is_valid = true;
        }
        else {
            ++hit_num;
        }
        ++total_num;
    }

    return static_cast<float>(hit_num) / total_num;
}
