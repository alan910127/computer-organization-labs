#pragma once

#include <iostream>
#include <string>
#include <vector>

/**
 * @brief Perform the n-way set associative cache and calculate the hit rate
 *
 * @param filename the file to specified the accessing sequence
 * @param way the size of a set
 * @param block_size size of a block in byte
 * @param cache_size size of the cache in byte
 * @return hit rate
 */
float set_associative(std::string file, int way, int block_size, int cache_size);
