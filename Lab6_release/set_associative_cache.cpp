#include "set_associative_cache.h"
#include "cache_utilities.h"

#include <string>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;

float set_associative(string filename, int way, int block_size, int cache_size) {

    constexpr int ADDRESS_SIZE = 32;

    int total_num = 0;
    int hit_num = 0;

    int number_blocks = cache_size / block_size;
    int number_sets = number_blocks / way;

    int block_offset_size = get_indexing_size(block_size);
    int index_size = get_indexing_size(number_sets);
    int tag_size = ADDRESS_SIZE - block_offset_size - index_size;

    int index_offset = block_offset_size;
    int tag_offset = index_offset + index_size;

    vector<Set> cache(number_sets, Set(way));

    ifstream file { filename };

    uint32_t address;
    while (file >> hex >> address) {
        auto index = get_bits(address, index_offset, index_size);
        auto tag = get_bits(address, tag_offset, tag_size);

        if (cache[index].add_block(tag)) ++hit_num;
        ++total_num;
    }

    return static_cast<float>(hit_num) / total_num;
}
